#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "mp5.h"
#include "mp10.h"


//
// These variables hold the heads of two singly-linked lists of 
// requests.  
//
// The avaialble list consists of unpaired requests: partner 
// should be NULL, and next is used to form the list.   
// 
// The shared list consists of groups with non-empty start and end 
// vertex intersections.  Only one of the requests in the group is in 
// the list.  The others are linked through the first's partner field 
// and then through the next field of the others in the group.  The 
// next field of the first request in a group is used to form the
// shared list.
//
// Note: for MP2, you should only build groups of two in the shared
// list.
//

static request_t* available = NULL;
static request_t* shared = NULL;

/*
* handle request -- processes a single request, allocate structures as necessary, compare with all unpaired requests in available list
*                   If a match is found, the function moves the new request and the matching request into shared list.
* INPUTS: g -- pointer to graph
*         p -- pointer to pyramid tree (use for find_nodes)
*         h -- pointer to heap (use for dijkstra)
*         r -- pointer to request
* OUTPUS: available -- singly linked list with requests that haven't been matched
*         shared -- singly linked list with match requests
* RETURN VALUE: 1 -- success
*               0 -- fail
* SIDE EFFECT: none
*/

int32_t
handle_request (graph_t* g, pyr_tree_t* p, heap_t* h, request_t* r)
{   
    //new_vertex_set will allocate space for both vs and id array
    if(NULL == (r->src_vs = new_vertex_set())){
        return 0;
    }
    if(NULL == (r->dst_vs = new_vertex_set())){
        free_vertex_set(r->src_vs);
        return 0;
    }

    //inside the find_nodes the dynamic allocated array will grow with the nodes num
    find_nodes(&r->from, r->src_vs, p, 0);
    find_nodes(&r->to, r->dst_vs, p, 0);

    if(r->src_vs->count == 0 || r->dst_vs->count == 0 ){
        free_vertex_set(r->src_vs);
        free_vertex_set(r->dst_vs);
        return 0;
    }

    build_vertex_set_minimap(g, r->src_vs);
    build_vertex_set_minimap(g, r->dst_vs);

    vertex_set_t* tempsrc;
    vertex_set_t* tempdst;
    path_t * temppath = NULL;

    //allocate space for the temporary storage
    if(NULL == (temppath = new_path())){
        free_vertex_set(r->src_vs);
        free_vertex_set(r->dst_vs);
        return 0;
    }

    if(NULL == (tempsrc = new_vertex_set())){
        free_vertex_set(r->src_vs);
        free_vertex_set(r->dst_vs);
        free_path(temppath);
        return 0;
    }
    if(NULL == (tempsrc->id = realloc(tempsrc->id, r->src_vs->count * sizeof(*r->src_vs->id)))){
        free_path(temppath);
        free_vertex_set(tempsrc);
        free_vertex_set(r->src_vs);
        free_vertex_set(r->dst_vs);
        return 0;
    }

    if(NULL == (tempdst = new_vertex_set())){
        free_path(temppath);
        free_vertex_set(tempsrc);
        free_vertex_set(r->src_vs);
        free_vertex_set(r->dst_vs);
        return 0;
    }

    if(NULL == (tempdst->id = realloc(tempdst->id, r->dst_vs->count * sizeof(*r->dst_vs->id)))){
        free_path(temppath);
        free_vertex_set(tempsrc);
        free_vertex_set(tempdst);
        free_vertex_set(r->src_vs);
        free_vertex_set(r->dst_vs);
        return 0;
    }

    if(NULL == (r->path = new_path())){
        free_path(temppath);
        free_vertex_set(tempsrc);
        free_vertex_set(tempdst);
        free_vertex_set(r->src_vs);
        free_vertex_set(r->dst_vs);
        return 0;
    }

    if(available == NULL){
        //first request should be inserted into the available list directly
        r->next = available;
        available = r;
        return 1;
    }

    request_t**  iterator;
    for(iterator = &available; *iterator != NULL; iterator = &((*iterator)->next)){
        if(!((*iterator)->src_vs->minimap & r->src_vs->minimap) ){
            //don't match in source vertex
            continue;
        }
        if(!((*iterator)->dst_vs->minimap & r->dst_vs->minimap) ){
            //don't match in destination vertex
            continue;
        }
        if(!merge_vertex_sets(r->src_vs, (*iterator)->src_vs,tempsrc)){
            continue;
        }
        if(!merge_vertex_sets(r->dst_vs, (*iterator)->dst_vs,tempdst)){
            continue;
        }
        if(!dijkstra(g, h, tempsrc, tempdst, temppath)){
            continue;
        }
        
        // delete from available
        request_t * temp = *iterator;
        (*iterator) = (*iterator)->next;
        // add to shared list
        r->next = shared;
        shared = r;

        
        free_vertex_set(r->src_vs);
        free_vertex_set(r->dst_vs);
        free_vertex_set(temp->src_vs);
        free_vertex_set(temp->dst_vs);

        build_path_minimap(g,temppath);
        free_path(temp->path);

        build_vertex_set_minimap(g,tempsrc);
        build_vertex_set_minimap(g,tempdst);

        r->partner = temp;
        r->partner->src_vs = r->src_vs = tempsrc;
        r->partner->dst_vs = r->dst_vs = tempdst;
        r->partner->path = r->path = temppath;
        r->partner->next = NULL;
        
        //debug blog : mysterious things happened here
        // if I annotating the following code, there will be no error. 
        // free_vertex_set(tempsrc);
        // free_vertex_set(tempdst);
        // free_path(temppath);

        return 1;
        } 
    r->next = available;
    available = r;
    // free_vertex_set(tempsrc);
    // free_vertex_set(tempdst);
    // free_path(temppath);
    return 1;

    request_t* match = available;
    request_t* prev = NULL;
    while ( NULL != match ){
        if ( ( (r->src_vs->minimap & match->src_vs->minimap) == 0) ||
             ( (r->dst_vs->minimap & match->dst_vs->minimap) == 0) ||
             merge_vertex_sets(r->src_vs,match->src_vs,tempsrc) == 0 || 
             merge_vertex_sets(r->dst_vs,match->dst_vs,tempdst) == 0 ){
            prev = match;
            match = match->next;
            continue; // if there's no common point
        }
        if ( dijkstra(g,h,tempsrc,tempdst,temppath) ){
            build_path_minimap(g,temppath);
            // delete from available
            if ( NULL == prev ){
                available = available->next;
            } else {
                prev->next = match->next;
            }
            // add to shared list
            if ( NULL == shared ){
                shared = r;
            } else {
                r->next = shared;
                shared = r;
            }
            free_vertex_set(r->src_vs);
            free_vertex_set(r->dst_vs);
            free_vertex_set(match->src_vs);
            free_vertex_set(match->dst_vs);
            build_vertex_set_minimap(g,tempsrc);
            build_vertex_set_minimap(g,tempdst);
            r->partner = match;
            r->partner->src_vs = r->src_vs = tempsrc;
            r->partner->dst_vs = r->dst_vs = tempdst;
            r->partner->path = r->path = temppath;
            r->partner->next = NULL;
            return 1;
        } else {
            prev = match;
            match = match->next;
            continue;
        }
    }
    free_vertex_set(tempsrc);
    free_vertex_set(tempdst);
    free_path(temppath);
    // add request to the front of available
    r->next = available;
    available = r;
    return 1;

}








void
print_results ()
{
    request_t* r;
    request_t* prt;

    printf ("Matched requests:\n");
    for (r = shared; NULL != r; r = r->next) {
        printf ("%5d", r->uid);
	for (prt = r->partner; NULL != prt; prt = prt->next) {
	    printf (" %5d", prt->uid);
	}
	printf (" src=%016lX dst=%016lX path=%016lX\n", r->src_vs->minimap,
		r->dst_vs->minimap, r->path->minimap);
    }

    printf ("\nUnmatched requests:\n");
    for (r = available; NULL != r; r = r->next) {
        printf ("%5d src=%016lX dst=%016lX\n", r->uid, r->src_vs->minimap,
		r->dst_vs->minimap);
    }
}



int32_t
show_results_for (graph_t* g, int32_t which)
{
    request_t* r;
    request_t* prt;

    // Can only illustrate one partner.
    for (r = shared; NULL != r; r = r->next) {
	if (which == r->uid) {
	    return show_find_results (g, r, r->partner);
	}
	for (prt = r->partner; NULL != prt; prt = prt->next) {
	    if (which == prt->uid) {
		return show_find_results (g, prt, r);
	    }
	}
    }

    for (r = available; NULL != r; r = r->next) {
        if (which == r->uid) {
	    return show_find_results (g, r, r);
	}
    }
    return 0;
}


static void
free_request (request_t* r)
{
    free_vertex_set (r->src_vs);
    free_vertex_set (r->dst_vs);
    if (NULL != r->path) {
	free_path (r->path);
    }
    free (r);
}

void
free_all_data ()
{
    request_t* r;
    request_t* prt;
    request_t* next;

    // All requests in a group share source and destination vertex sets
    // as well as a path, so we need free those elements only once.
    for (r = shared; NULL != r; r = next) {
	for (prt = r->partner; NULL != prt; prt = next) {
	    next = prt->next;
	    free (prt);
	}
	next = r->next;
	free_request (r);
    }

    for (r = available; NULL != r; r = next) {
	next = r->next;
	free_request (r);
    }
}


