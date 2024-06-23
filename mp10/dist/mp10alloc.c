#include <stdint.h>
#include <stdlib.h>

#include "mp10.h"

/*
* new_vertex_set -- allocate a new vertex set, initialize the count field and id array
* INPUTS: none
* OUTPUS: none
* RETURN VALUE: NULL -- failure / new_vertex_set pointer -- success
* SIDE EFFECT: initialize the count field to zero
*              dynamic allocate space for id array
*              initialize the id_array_size field to one
*/

vertex_set_t*
new_vertex_set ()
{
    vertex_set_t * vs;
    if(NULL == (vs = malloc(sizeof(*vs)))){
        return NULL;
    }
    vs->count = 0;
    if(NULL == (vs->id = malloc(sizeof(*vs->id)))){
        free(vs);
        return NULL;
    }
    vs->id_array_size = 1;
    return vs;
}

/*
* free_vertex_set -- free a vertex set and its id array.
* INPUTS: pointer to vertex set
* OUTPUS: none
* RETURN VALUE: none
* SIDE EFFECT: none
*/

void
free_vertex_set (vertex_set_t* vs)
{
    if(vs != NULL){
        //avoid difference NULL pointer
        if(vs->id != NULL){
            free(vs->id);
        }
        free(vs);
    }
}

/*
* new_path -- allocate a new path, initialize the n_vertices & tot_dist field and id array
* INPUTS: none
* OUTPUS: none
* RETURN VALUE: NULL -- failure / new path_t pointer -- success
* SIDE EFFECT: initialize the n_vertices & tot_dis field to zero
*              initialzie id array point to NULL
*/

path_t*
new_path ()
{
    path_t * path;
    if(NULL == (path = malloc(sizeof(*path)))){
        return NULL;
    }
    path->n_vertices = 0;
    path->tot_dist = -1;
    path->id = NULL;
    return path;
}

/*
* free_path -- free a path and its id array
* INPUTS: pointer to path
* OUTPUS: none
* RETURN VALUE: none
* SIDE EFFECT: none
*/


void
free_path (path_t* path)
{   
    if(path != NULL){
        //avoid difference NULL pointer
        if(path->id != NULL){
            free(path->id);
        }
        free(path);
    }
}

