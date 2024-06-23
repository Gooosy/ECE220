#include <stdint.h>
#include <stdio.h>

#include "mp5.h"
#include "mp9.h"

#define MY_INFINITY   1000000000

/*
* find_nodes -- start at array index nnum and walk the pyramid tree recursively in
*               order to fill the vertex set vs with the array indices of any graph vertices 
*               found to be in range of locale
*    
* INPUTS: p -- pointer to pyramid tree
*         loc -- targeted location, other vertexs should locale within distance from (loc->x,loc->y)
*         nnum -- index of pyramid tree
* OUTPUTS: vs -- filled with graph vertices in range of local
* RETURN VALUE: none
* SIDE EFFECT: if the given nnum is out of range or the number of vertices in array is larger than MAX_IN_VERTEX_SET
*              return immediately without excuting other instructions
*/

void
find_nodes (locale_t* loc, vertex_set_t* vs, pyr_tree_t* p, int32_t nnum)
{
    // Do not modify the following line nor add anything above in the function.
    record_fn_call ();
    if(nnum >= p->n_nodes){
        //out of range, error call
        return;
    }

    int32_t x = p->node[nnum].x;
    int32_t yl = p->node[nnum].y_left;
    int32_t yr = p->node[nnum].y_right;

    if(4 * nnum + 1 > p->n_nodes){
        //check if the node is graph vertexs (leaf nodes)
        //graph vertex represents as (x,y_left)
        if(in_range(loc, x, yl)){
            if(vs->count >= MAX_IN_VERTEX_SET){
                //out of range
                return;
            }
            vs->id[vs->count++] = p->node[nnum].id;
            return;
        }
        return;
    }

    //not leaf nodes, search for leaf nodes in the range
    //use internal x, y_left, y_right as condition to decide which node should be search
    int32_t node[4] = {4*nnum + 1, 4*nnum + 2 , 4*nnum + 3, 4*nnum + 4};
    int32_t search[4] = {1,1,1,1}; //flag array
    if(!in_range(loc,x,loc->y)){
        if(x < loc->x){
            //shouldn't search 4N+1 4N+3
            search[0] = search[2] = 0;
        }else if(x > loc->x){
            //because if x == loc->x we can't decide which node to be search
            //shouldn't search 4N+2 4N+4
            search[1] = search[3] = 0;
        }
    }

    if(!in_range(loc,loc->x,yr)){
        if(yr < loc->y){
            //shouldn't search 4N+2
            search[1] = 0;
        }else if(yr > loc->y){
            //shouldn't search 4N+4
            search[3] = 0;
        }
    }

    //same as y_right judge y_left
    if(!in_range(loc,loc->x,yl)){
        if(yl < loc->y){
            //shouldn't search 4N+1
            search[0] = 0;
        }else if(yl > loc->y){
            //shouldn't search 4N+3
            search[2] = 0;
        }
    }

    //search recursively
    for(int32_t i = 0; i < 4; i++){
        if(search[i]){
            find_nodes(loc, vs, p, node[i]);
        }
    }
}

/*
* trim_nodes -- remove any graph vertices not in range of a locale from a vertex set
* INPUTS: g -- pointer to graph
*         vs -- pointer to original vertex set
*         loc -- targeted location, other vertexs should locale within distance from (loc->x,loc->y)
* OUTPUTS: vs -- vertex set with vertexs not in locale removed
* RETURN VALUE: none
* SIDE EFFECT: none
*/

void
trim_nodes (graph_t* g, vertex_set_t* vs, locale_t* loc)
{
    int32_t i;
    int32_t x;
    int32_t y;
    for(i = 0; i < vs->count; i++){
        x = g->vertex[vs->id[i]].x;
        y = g->vertex[vs->id[i]].y;
        if(!in_range(loc, x, y)){
            //node need to be remove
            if(i != vs->count-1){
                vs->id[i--] = vs->id[--vs->count];
                //use the last element to replace the removed one
                //the i should minus one after exchange
                //as the element haven't been examined
            }else{
                //if the removed element is the last element in the array
                vs->count--;
            } 
        }
    }
}

/*
* heap_init -- step the heap length and push all starting points into heap
*           -- set the distance field of source vertices in the graph to zero
*           -- set the predecessor field of source vertices in the graph to -1, indicate no predecessor vertices
* INPUTS: g -- pointer to graph
*         h -- pointer to heap
*         src -- starting vertex set
* OUTPUTS: h -- initialized heap
* RETURN VALUE: none
* SIDE EFFECT: none
*/

void heap_init(heap_t* h, vertex_set_t* src, graph_t* g){
    int32_t i;
    h->n_elts = 0;
    for(i = 0; i < src->count ; i++){
        h->elt[h->n_elts] = src->id[i];
        g->vertex[src->id[i]].heap_id = h->n_elts++;
        g->vertex[src->id[i]].from_src = 0;
        g->vertex[src->id[i]].pred = -1;
    }
}

/*
* heap_swap -- exchange two given vertexs
* INPUTS: g -- pointer to graph
*         h -- pointer to heap
*         id1 -- first heap array index 
*         id2 -- second heap array index 
* OUTPUTS: g -- graph with vertexs' heap_id swapped
*          h -- vertexs index in the heap array swapped
* RETURN VALUE: none
* SIDE EFFECT: none
*/

void heap_swap(int32_t id1, int32_t id2, heap_t * h, graph_t * g){
    int32_t temp;
    temp = h->elt[id1];
    g->vertex[h->elt[id1]].heap_id = id2;
    g->vertex[h->elt[id2]].heap_id = id1;
    h->elt[id1] = h->elt[id2];
    h->elt[id2] = temp;
}

/*
* heap_percolatedown -- move targeted vertex down in the heap to maintain heap property recursively
*                    -- used when heap_pop pop exchange the first element with last
* INPUTS: g -- pointer to graph
*         h -- pointer to heap
*         id -- heap array index for element to be percolated down
* OUTPUTS: g -- graph right heap_id field 
*          h -- heap meet the heap property
* RETURN VALUE: none
* SIDE EFFECT: none
*/

void heap_percolatedown(int32_t id, graph_t* g, heap_t * h){
    if(2 *id + 1 >= h->n_elts){
        //already at the bottom
        return;
    }

    if(g->vertex[h->elt[id]].from_src <= g->vertex[h->elt[id * 2 + 1]].from_src){
        if(2 * id + 2 >= h->n_elts || g->vertex[h->elt[id]].from_src <= g->vertex[h->elt[id * 2 + 2]].from_src){
            //no need to swap
            return;
        }
        heap_swap(id, id * 2 + 2, h, g);
        heap_percolatedown(id * 2 + 2, g, h);
        //recursively percolate
        return;
    }

    if(2 * id + 2 >= h->n_elts || g->vertex[h->elt[id]].from_src <= g->vertex[h->elt[id * 2 + 2]].from_src){
        //swap with the left child
        heap_swap(id, id * 2 + 1, h, g);
        heap_percolatedown(id * 2 + 1, g, h);
        return;
    }
    //swap with the smaller child

    if(g->vertex[h->elt[id * 2 + 1]].from_src <= g->vertex[h->elt[id * 2 + 2]].from_src){
        heap_swap(id, id * 2 + 1, h, g);
        heap_percolatedown(id * 2 + 1, g, h);
        return;
    }

    heap_swap(id, id * 2 + 2, h, g);
    heap_percolatedown(id * 2 + 2, g, h);
}

//pop the head element from the heap 
//decrease the heap length and maintain heap property

int32_t heap_pop(graph_t * g, heap_t * h){
    if(h->n_elts == 0){
        //empty heap 
        return -1;
    }
    int32_t res = h->elt[0];
    //swap the first heap element with the last and decreament the heap length
    heap_swap(0,--h->n_elts, h, g);
    heap_percolatedown(0, g, h);
    //maintain heap property
    return res;
}

/*
* heap_percolateup -- move targeted vertex up in the heap to maintain heap property recursively
*                  -- used when insert new vertexs into the heap
* INPUTS: g -- pointer to graph
*         h -- pointer to heap
*         id -- heap array index for element to be percolated up
* OUTPUTS: g -- graph right heap_id field 
*          h -- heap meet the heap property
* RETURN VALUE: none
* SIDE EFFECT: none
*/

void heap_percolateup(int32_t id, graph_t * g, heap_t* h){
    int32_t parent = (id - 1)/2;
    if(g->vertex[h->elt[id]].from_src >= g->vertex[h->elt[parent]].from_src){
        //no need to percolate
        return;
    }
    heap_swap(id, parent, h, g);
    heap_percolateup(parent, g, h);//recursively percolate up to maintain heap property
}

/*
* dijkstra -- find the shortest path between any node in the src vertex set and any
*          -- node in the destination vertex set, and write that path into path
* INPUS: g -- point to graph
*        h -- pointer to heap
*        src -- source vertex set
*        dest -- destination vertex set
* OUTPUTS: path -- array of the shortest path
* RETURN VALUE: 0 -- Failure (when the source vertexs set or destination vertex set is out of range or when the path is too long)
*               1 -- Success
* SIDE EFFECT: none
*/

int32_t
dijkstra (graph_t* g, heap_t* h, vertex_set_t* src, vertex_set_t* dest, path_t* path)
{
    int32_t i, id, num, neighborid;
    if(src->count <= 0 || src->count > MAX_IN_VERTEX_SET ||src->count >= g->n_vertices ||
        dest->count <= 0 || dest->count > MAX_IN_VERTEX_SET || dest->count >= g->n_vertices ){
        //first rule out the error call
        return 0;
    }

    //initialize the graph
    for(i = 0; i < g->n_vertices; i++){
        g->vertex[i].from_src = MY_INFINITY;
        g->vertex[i].heap_id = -1; //initially not in the heap
    }

    heap_init(h, src, g);
    //star implement of dijkstra algorithm
    id = heap_pop(g, h);
    while(id != -1){
        for(num = 0; num < g->vertex[id].n_neighbors ; num ++){
            neighborid = g->vertex[id].neighbor[num];
            if(g->vertex[neighborid].from_src > g->vertex[id].from_src + g->vertex[id].distance[num]){
                //update the distance
                g->vertex[neighborid].from_src = g->vertex[id].from_src + g->vertex[id].distance[num];
                g->vertex[neighborid].pred = id;
                if(g->vertex[neighborid].heap_id == -1){
                    //not in the heap
                    g->vertex[neighborid].heap_id = h->n_elts;
                    h->elt[h->n_elts++] = neighborid;
                    //add the new neighbor into the heap
                }
                heap_percolateup(g->vertex[neighborid].heap_id, g, h);//maintain heap property
            }
        }
        id = heap_pop(g, h);
    }

    //create the path
    int32_t min = MY_INFINITY;
    int32_t minid;
    //from destinate vertices find the smallest distance
    for (i = 0; i < dest->count ; i++){
        if(g->vertex[dest->id[i]].from_src < min){
            min = g->vertex[dest->id[i]].from_src;
            minid = dest->id[i];
        }
    }
    
    path->tot_dist = min;
    path->n_vertices = 0;
    int32_t pathreverse[MAX_PATH_LENGTH];
    while(minid != -1){
        if(path->n_vertices >= MAX_PATH_LENGTH){
            return 0;
        }
        pathreverse[path->n_vertices++] = minid;
        minid = g->vertex[minid].pred;
    }
    //reverse the path back
    for(i = 0; i < path->n_vertices ; i++ ){
        path->id[i] = pathreverse[path->n_vertices - 1 - i];
    }
    return 1;
}

