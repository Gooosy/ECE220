#include <stdint.h>
#include <stdio.h>

#include "mp10.h"

/* 
* mark_vertex_minimap -- marks graph vertices in g with a minimap 
* INPUTS: g -- pointer to graph
*         p -- pointer to pyramid tree
* OUTPUTS: g -- graph with vertices marked with mm_bit
* RETURN VALUE: none
* SIDE EFFECT: none
*/

int32_t 
mark_vertex_minimap (graph_t* g, pyr_tree_t* p)
{
    int32_t i,j;
    if(g->n_vertices <= 64){
        //use graph index for mm_bit
        for(i = 0; i < g->n_vertices ; i++){
            g->vertex[i].mm_bit = i;
        }
        return 1;
    }
    int32_t firstleaf = (p->n_nodes + 2 ) / 4;
    for(i = firstleaf; i < p->n_nodes ; i++){
        //for every leaf node try to find the ancesstor and store it in the graph
        for(j = i; j > 84 ; j = (j - 1)/4){}
        if(j >= 21 && j <= 84){
            g->vertex[p->node[i].id].mm_bit = j - 21;
        }
    }
    return 1;
}


/* 
* build_vertex_set_minnimap -- ORing together the bits for all ids in the vertex set 
*                              store the results in the minimap field of vertex set
* INPUTS: g -- pointer to graph
*         vs -- pointer to vertex set
* OUTPUTS: vs -- vertex set with minimap field set 
* RETURN VALUE: none
* SIDE EFFECT: none
*/

void 
build_vertex_set_minimap (graph_t* g, vertex_set_t* vs)
{
    vs->minimap = 0;
    for (int32_t i = 0; i < vs->count ; i ++){
        vs->minimap |= 1ULL << g->vertex[vs->id[i]].mm_bit;
    }
}

/* 
* build_path_minnimap -- ORing together the bits for all ids in the path 
*                        store the results in the minimap field of path
* INPUTS: g -- pointer to graph
*         p -- pointer to path
* OUTPUTS: p -- path with minimap field set 
* RETURN VALUE: none
* SIDE EFFECT: none
*/

void 
build_path_minimap (graph_t* g, path_t* p)
{
    p->minimap = 0;
    for (int32_t i = 0; i < p->n_vertices ; i ++){
        p->minimap |= 1ULL << g->vertex[p->id[i]].mm_bit;
    }
}

/* 
* merge_vertex_sets -- find common vertex id of v1 and v2 and fill vint id & count field
*                      
* INPUTS: v1 -- pointer to first vertex set
*         v2 -- pointer to second vertex set
*         vint -- vertex set contain common id info
* OUTPUTS: vint -- vertex set filled with common id in v1 and v2
* RETURN VALUE: 0 -- no common vertex found
*               1 -- at least one common vertex found
* SIDE EFFECT: none
*/

int32_t
merge_vertex_sets (const vertex_set_t* v1, const vertex_set_t* v2,
		   vertex_set_t* vint)
{
    vint->count = 0;
    int32_t i = 0, j = 0;
    //i is index of v1 id array, j is the index of v2 id array
    while (i < v1->count && j < v2->count){
        if(v1->id[i] == v2->id[j]){
            vint->id[vint->count++] = v1->id[i];
            i++;
            j++;
            continue;
        }
        if(v1->id[i] < v2->id[j]){
            i++;
            continue;
        }
        if(v1->id[i] > v2->id[j]){
            j++;
            continue;
        }
    }
    return vint->count != 0;
}

