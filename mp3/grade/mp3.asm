.ORIG x3000
;this program call the DIJSTRA subroutine to calculate shortest path of each node
;the DIJSTRA will return a calulated predecessor array
;the program then call fill_stack & print_path to display each path

LD R4,PROGRAM_MATRIX
LDR R0,R4,#-2
JSR DIJKSTRA
LD R6,PROGRAM_STACK
LD R4,PROGRAM_MATRIX ;JSR change it 
LDR R2,R4,#-1 ;the number of the nodes
BRz END_PROGRAM
NOT R2,R2
ADD R2,R2,#1  ;-number
AND R1,R1,#0
OUTPUT_LOOP
JSR FILL_STACK
JSR PRINT_PATH
ADD R1,R1,#1
ADD R3,R1,R2
BRn OUTPUT_LOOP

END_PROGRAM
HALT

PROGRAM_MATRIX .FILL x4000
PROGRAM_STACK .FILL xC000



DIJKSTRA
;this subroutine will perform the dijkstra algorithm to find the shortest path from source node
;it will be divided into three steps and each step will contain annotation about what this step for
ST R7,DIJK_R7

;**initialize**
;R1 <-- x5000 predessor array pointer
;R2 <-- x6000 dist array pointer 
;R3 <-- x7000 index array pointer
;R4 <-- v the number of the node
;R5 <-- temporary use (x7FFF infinite/-1)
;R6 <-- x8000 heap pointer
;R7 <-- temporary use
;while v>0:
;       v <-- v-1
;       M[v+R1]=-1
;       M[v+R2]=infinie(R5)
;       M[v+R3]=-1

LD R1,DIJK_PREDESSOR
LD R2,DIJK_DIST
LD R3,DIJK_INDEX
LD R4,DIJK_NODEMATRIX
LDR R4,R4,#-1
LD R6,DIJK_HEAP

INIT_LOOP
ADD R4,R4,#0
BRnz FINISH_INIT
ADD R4,R4,#-1 ;the node index is one less than length,so substract first
ADD R7,R4,R1
AND R5,R5,#0
ADD R5,R5,#-1
STR R5,R7,#0  
ADD R7,R4,R3
STR R5,R7,#0
ADD R7,R4,R2
LD R5,INFINIE
STR R5,R7,#0
BRnzp INIT_LOOP

FINISH_INIT
;**insert start node to heap**
;input R0 - source node
;dist(R0) <-- 0
;index(R0) <-- 0
;heap(0) <-- R0
;length <-- leagth + 1

ADD R7,R2,R0
AND R5,R5,#0
STR R5,R7,#0
ADD R7,R3,R0
STR R5,R7,#0
STR R0,R6,#0
LDR R5,R6,#-1
ADD R5,R5,#1
STR R5,R6,#-1


;**process the node until heap is empty(contain the most important relaxing process)**
;N = GET_CLOSE()   remove the root node (closest distance) from heap ready to explore its adjacent nodes
;N is contained in register R0
;While N != -1 
;       M <- v-1
;       while M >= 0
;                   if  arc(N,M) == INFINITE
;                            M <-- M-1
;                   else
;                           if dist(M) > dist(N) + arc(N,M)
;                                   dist(M) = dist(N) + arc(N,M)
;                                   pre(M) = N 
;                                   if index(M) == -1
;                                           index(M) = length
;                                           heap(length) = M
;                                           length <-- length + 1
;                                   PERCOLATE_UP(index(M)) -- here need to change R0 = index(M)
;                                   M <-- M-1
;                           else
;                                   M <-- M-1
;       N=GET_CLOSE()


;registers are used as follows:
;R0 - N/index(M)
;R1 - M                                   
;R2 - arc(N,M)
;R3 - x5000 predessor array pointer / x7000 index array pointer
;R4 - x6000 dist array pointer / x8000 heap array pointer
;R5 - temporary store
;R6 - temporary store

DIJK_LOOP1
JSR GET_CLOSEST
ADD R0,R0,#0
BRn DIJK_LOOP1DONE
ST R0,DIJK_R0
LD R1,DIJK_NODEMATRIX
LDR R1,R1,#-1
ADD R1,R1,#-1 ;M <- v-1
BRn DIJK_LOOP1
DIJK_LOOP2
JSR ARC
LD R5,INFINIE
NOT R5,R5
ADD R5,R5,#1
ADD R5,R5,R2
BRz DIJK_NEXT
LD R4,DIJK_DIST
ADD R5,R4,R0
LDR R5,R5,#0 ;dist(N)
ADD R6,R4,R1
LDR R6,R6,#0 ;dist(M)
ADD R5,R5,R2 ;dist(N)+arc(N,M)
NOT R6,R6
ADD R6,R6,#1
ADD R6,R5,R6 ;dist(N)+arc(N,M)-dist(M)
BRzp DIJK_NEXT
;R5 contain dist(N)+arc(N,M)
ADD R6,R4,R1
STR R5,R6,#0
LD R3,DIJK_PREDESSOR
ADD R6,R3,R1
STR R0,R6,#0
LD R3,DIJK_INDEX
ADD R3,R3,R1 ;indexM
LDR R6,R3,#0 ;index(M)
LD R5,MINUSONE
NOT R5,R5
ADD R5,R5,#1
ADD R5,R5,R6
BRn ALREADYIN ;if index(M) == -1
LD R4,DIJK_HEAP
LDR R6,R4,#-1 ;R6<-length
STR R6,R3,#0  ;index(M)=length
ADD R0,R6,#0  ;change R0 to index(M) used for PERCOLATE_UP
ADD R6,R4,R6 ;heapindex
STR R1,R6,#0
LDR R6,R4,#-1
ADD R6,R6,#1 ;length+1
STR R6,R4,#-1 ;store back
JSR PERCOLATE_UP ;inorder to percolate up R0 should contain index(M)
BRnzp DIJK_NEXT

ALREADYIN
ADD R0,R6,#0 ;change r0 to index(M) used for ALREADYIN
JSR PERCOLATE_UP ;inorder to percolate up R0 should contain index(M)
BRnzp DIJK_NEXT

DIJK_NEXT
LD R0,DIJK_R0
ADD R1,R1,#-1
BRzp DIJK_LOOP2
BRnzp DIJK_LOOP1

DIJK_LOOP1DONE
LD R7,DIJK_R7
RET
DIJK_R0 .BLKW #1
DIJK_R7 .BLKW #1
DIJK_NODEMATRIX .FILL x4000
DIJK_PREDESSOR  .FILL x5000
DIJK_DIST       .FILL x6000
DIJK_INDEX      .FILL x7000
DIJK_HEAP       .FILL x8000
INFINIE         .FILL x7FFF
MINUSONE 		.FILL #-1




ARC
;**subroutine arc**
;this function will calculate the distance between node N and M
;input R0 - N
;      R1 - M
;output R2 - the distance between node N and M
;calculate MATRIX(N*V+M)
;registers:
;R0 - N
;R1 - M
;R2 - distance
;R3 - x4000 matrix pointer
;R4 - v
;callee save

ST R0,ARCST_R0
ST R1,ARCST_R1
ST R3,ARCST_R3
ST R4,ARCST_R4

LD R3,ARCMATRIX
LDR R4,R3,#-1
AND R2,R2,#0
ADD R0,R0,#0
BRnz MATRIX_LOOPDONE
MATRIX_LOOP
ADD R2,R2,R4
ADD R0,R0,#-1
BRp MATRIX_LOOP

MATRIX_LOOPDONE
ADD R2,R2,R1
ADD R2,R2,R3
LDR R2,R2,#0 ;MATRIX(N*V+M)
LD R0,ARCST_R0
LD R1,ARCST_R1
LD R3,ARCST_R3
LD R4,ARCST_R4
RET

ARCST_R0 .BLKW #1
ARCST_R1 .BLKW #1
ARCST_R3 .BLKW #1
ARCST_R4 .BLKW #1
ARCMATRIX .FILL x4000


SWAP_ELEMENTS
;this subroutine will swich two elements in the heap
;input R0 - heap index 1
;      R1 - heap index 2
;first use R0,R1 and heap array to get the node
;then change the heap array at x8000
;use the node to index heap indices array at x7000
;exchange the two nodes's index
;output NO directly change two arrays
;register used as follows:
;R0 - the input heap indices, specified which nodes to change
;R1 - the input heap indices, specified which nodes to change
;R2 - the node calculated by R0
;R3 - sthe node calculated by R1
;R4 - store the starting address of array(x8000/x7000)
;R5 - specify the address calculated based on R0
;R6 - specify the address calculated based on R1

ST R2,SE_R2
ST R3,SE_R3
ST R4,SE_R4
ST R5,SE_R5
ST R6,SE_R6

LD R4,HEAP
ADD R5,R4,R0
ADD R6,R4,R1
LDR R2,R5,#0
LDR R3,R6,#0
STR R3,R5,#0
STR R2,R6,#0 ;switch the element in array of heap

LD R4,HEAP_INDICES
ADD R2,R2,R4
ADD R3,R3,R4
STR R1,R2,#0
STR R0,R3,#0 ;change the heap indices to match heap property

LD R2,SE_R2
LD R3,SE_R3
LD R4,SE_R4
LD R5,SE_R5
LD R6,SE_R6
RET

HEAP .FILL x8000
HEAP_INDICES .FILL x7000
SE_R2 .BLKW #1
SE_R3 .BLKW #1
SE_R4 .BLKW #1
SE_R5 .BLKW #1
SE_R6 .BLKW #1

PERCOLATE_UP
; Percolates the heap element with index given by R0 upward in the heap if necessary.
; Heap stores node numbers and is sorted by distance (smallest first).  Distances
; are stored in a separate table.  Uses SWAP_ELEMENTS to swap heap elements during
; percolation, so this subroutine does not need the heap index array.
;   INPUT: R0 -- the index of the heap element to percolate upward
;          M[x7FFF] -- the heap length
;          M[x8000..] -- a heap with length at M[x7FFF] and contents starting at M[x8000]
;            (each heap element consists of one memory location and holds a node number)
;          M[x6000..] -- an array of node distances, indexed by node number
;   OUTPUT: a modified heap and array of heap indices (latter modified by SWAP_ELEMENTS)
;   REGISTERS: All registers except R7 are callee-saved.
;   NOTES: modifies heap and array of heap indices
;          IMPLICITLY ASSUMES that heap elements are valid (< length of heap) and that
;            nodes in the heap are not at distance INFINITY (x7FFF)
;          For N > 0, parent of node N is ((N - 1) >> 1) = floor ((N - 1) / 2)

; Registers are used as follows:
;   R0 - heap element to percolate up if necessary
;   R1 - heap element index of parent
;   R2 - points to heap
;   R3 - points to node distance array
;   R4 - element distance
;   R5 - parent distance
	ST R0,PU_R0	; Save callee-saved registers.
	ST R1,PU_R1
	ST R2,PU_R2
	ST R3,PU_R3
	ST R4,PU_R4
	ST R5,PU_R5
	ST R7,PU_R7
	LD R2,PU_HEAP	; Get pointers to heap and distance arrays.
	LD R3,PU_DIST
	
PU_NEXT	ADD R0,R0,#0	; Can't move root up.
	BRz DONW1
	ADD R4,R2,R0	; Get element distance in R4.
	LDR R4,R4,#0
	ADD R4,R4,R3
	LDR R4,R4,#0
	JSR FIND_PARENT	; Find parent element index in R1.
	ADD R5,R2,R1	; Get parent distance in R5.
	LDR R5,R5,#0
	ADD R5,R5,R3
	LDR R5,R5,#0
	; Need to percolate up if parent distance is larger.
	; Compute (parent distance - element distance - 1) in R4.
	; NOTE: ASSUMES THAT ELEMENTS IN HEAP ARE NOT AT INFINITY
	NOT R4,R4
	ADD R4,R4,R5
	BRn DONW1
	; Swaps heap elements in R0 and R1 (in heap and in heap index array).
	JSR SWAP_ELEMENTS
	ADD R0,R1,#0	; Try again with parent.
	BRnzp PU_NEXT

DONW1	
	LD R0,PU_R0	; Restore callee-saved registers.
	LD R1,PU_R1
	LD R2,PU_R2
	LD R3,PU_R3
	LD R4,PU_R4
	LD R5,PU_R5
	LD R7,PU_R7
	RET

PU_HEAP	.FILL x8000
PU_DIST	.FILL x6000
PU_R0	.BLKW #1
PU_R1	.BLKW #1
PU_R2	.BLKW #1
PU_R3	.BLKW #1
PU_R4	.BLKW #1
PU_R5	.BLKW #1
PU_R7	.BLKW #1


PERCOLATE_DOWN
;PERCOLATE_DOWN will switch downward the heap element to maintain heap property
;input R0 - heap element to percolate down
;while 2x+1<l	
;	if 2x+2<l & distance(value(2x+2)) < distance(value(2x+1))
;		if distance(value(2x+2)) < distance(value(x))
;				swamp_elements(x,2x+2)
;				x=2x+2
;		else 
;				break
;	elseif distance(value(2x+1)) < distance(value(x))
;				swamp_elements(x,2x+1)
;				x=2x+1
;	else
;				break
;output NO directly change the heap and heap indices
; Registers are used as follows:
;   R0 - heap element to percolate down if necessary
;   R1 - temporary store
;   R2 - points to heap 
;   R3 - points to node distance array
;   R4 - element distance
;   R5 - child1 index(left)
;   R6 - child2 index(right)
;   R7 - temporary store the heap length

	ST R0,PD_R0	; Save callee-saved registers.
	ST R1,PD_R1
	ST R2,PD_R2
	ST R3,PD_R3
	ST R4,PD_R4
	ST R5,PD_R5
	ST R6,PD_R6
	ST R7,PD_R7
	LD R2,PD_HEAP	; Get pointers to heap and distance arrays.
	LD R3,PD_DIST
	
PD_NEXT	
	LD R7,PD_HEAP
	LDR R7,R7,#-1	;store the length of heap in R7
	NOT R7,R7		;-length
	ADD R7,R7,#1
	ADD R5,R0,R0
	ADD R5,R5,#1    ;left child
	ADD R1,R5,R7
	BRzp RECOVER1	;can't move down
	ADD R6,R0,R0
	ADD R6,R6,#2	;the right child
	ADD R1,R6,R7
	BRzp ELSE_IF
	ADD R4,R2,R6	;here I temporary use R4 to get the right child distance
	LDR R4,R4,#0
	ADD R4,R4,R3
	LDR R4,R4,#0
	ADD R1,R2,R5    ;use R1 temporary to get the left child distance
	LDR R1,R1,#0
	ADD R1,R1,R3
	LDR R1,R1,#0
	NOT R4,R4
	ADD R4,R4,#1
	ADD R4,R4,R1
	BRnz ELSE_IF
	ADD R4,R2,R0	; Get element distance in R4.
	LDR R4,R4,#0	;get the node
	ADD R4,R4,R3	
	LDR R4,R4,#0	;get the distance
	ADD R1,R2,R6	;get right child distance in R1
	LDR R1,R1,#0
	ADD R1,R1,R3
	LDR R1,R1,#0
	NOT R4,R4
	ADD R4,R4,#1
	ADD R4,R4,R1
	BRzp RECOVER1
	ADD R1,R6,#0
	JSR SWAP_ELEMENTS
	ADD R0,R6,#0  ;try gain with child
	BRnzp PD_NEXT

ELSE_IF             
	ADD R1,R2,R5	;here R1 store the left child distance
	LDR R1,R1,#0
	ADD R1,R1,R3
	LDR R1,R1,#0
	ADD R4,R2,R0	; Get element distance in R4.
	LDR R4,R4,#0	;get the node
	ADD R4,R4,R3	
	LDR R4,R4,#0	;get the distance
	NOT R4,R4
	ADD R4,R4,#1
	ADD R4,R4,R1
	BRzp RECOVER1
	ADD R1,R5,#0
	JSR SWAP_ELEMENTS
	ADD R0,R5,#0	; Try again with parent.
	BRnzp PD_NEXT

RECOVER1
	LD R0,PD_R0	; Restore callee-saved registers.
	LD R1,PD_R1
	LD R2,PD_R2
	LD R3,PD_R3
	LD R4,PD_R4
	LD R5,PD_R5
	LD R6,PD_R6
	LD R7,PD_R7
	RET

PD_HEAP	.FILL x8000
PD_DIST	.FILL x6000
PD_R0	.BLKW #1
PD_R1	.BLKW #1
PD_R2	.BLKW #1
PD_R3	.BLKW #1
PD_R4	.BLKW #1
PD_R5	.BLKW #1
PD_R6   .BLKW #1
PD_R7	.BLKW #1

GET_CLOSEST
;GET_CLOSEST will extract the root off the heap and ensure the heap property
;input NO: root serve as the element we operate
;R0 <- root
;R1 <- length
;if R1 == 0
;		R0 <- -1
;		end
;else 
;		l <- l-1
;		R0 <- index(root)
;		store R0
;		index(root)=-1
;		root=heap(l)
;		index(root)=0
;		R0 <- 0 ready for call subroutine PERCOLATE_DOWN
;		PERCOLATE_DOWN(R0)
;		load R0 back
;		end
;output R0 -1 means the heap is empty, otherwise R0 contain the root that has been deleted
;registers are used as follows:
;R0 - output -1 means empty, other positive number means deleted root node number
;R1 - contain the heap length
;R2 - contain x8000 the start of the heap/x7000 the heap index array 
;R3 - contain the last element

ST R1,GC_R1
ST R2,GC_R2
ST R3,GC_R3
ST R4,GC_R4
ST R7,GC_R7

LD R2,GC_HEAP
LDR R0,R2,#0
LDR R1,R2,#-1
BRz EMPTY
ADD R1,R1,#-1
STR R1,R2,#-1  ;decrease the length of heap by one
ADD R3,R2,R1
LDR R3,R3,#0
STR R3,R2,#0 ;copy the last node to the root
;change the index array
LD R2,GC_INDEX
ADD R2,R2,R3
AND R3,R3,#0
STR R3,R2,#0   ;change the corresponding index of the last node to 0(root)
LD R2,GC_INDEX
ADD R2,R2,R0   ;get the index of the former root node
AND R4,R4,#0
ADD R4,R4,#-1
STR R4,R2,#0  ;store -1 to the index array of former root node
ST R0,GC_R0
ADD R0,R3,#0   ;R0 contain 0(root),ready for the percolate down
JSR PERCOLATE_DOWN
LD R0,GC_R0
BRnzp GC_REC

EMPTY
AND R0,R0,#0 ;R0 store -1
ADD R0,R0,#-1
BRnzp GC_REC

GC_REC
LD R1,GC_R1
LD R2,GC_R2
LD R3,GC_R3
LD R4,GC_R4
LD R7,GC_R7
RET

GC_R0 .BLKW #1
GC_R1 .BLKW #1
GC_R2 .BLKW #1
GC_R3 .BLKW #1
GC_R4 .BLKW #1
GC_R7 .BLKW #1
GC_HEAP .FILL x8000
GC_INDEX .FILL x7000

;  ***** PUT A COPY OF YOUR MP1 CODE HERE *****

;the first subroutine perform arithmetic 
;register table:
;R0:input number
;R1:final result
;R2:temporary store the result

FIND_PARENT ;first subroutine
ST R7,R7STORE
LEA R7,REG_COPY
STR R2,R7,#2 ;store the number currently in register R2 to memory
ADD R2,R0,#0 ;R2 store the R0
AND R1,R1,#0 ;initialze R1, ready store the result

ADD R2,R2,#-1
BRn STORE
DIVISION
ADD R2,R2,#-2
BRn STORE
ADD R1,R1,#1
BRnzp DIVISION


STORE
LEA R7,REG_COPY
LDR R2,R7,#2
LD R7,R7STORE
RET

;the second subroutine
;it push all the graph node on a specific path to a stack
;register table:
;R1:the last node in the path
;use to find the predecessor nodes
;in my codes I will temporary use it to contain the current nodes
;R6:the stack top pointer
;in the end the R6 still point to the current stack top
;R7:temporary store and can be changed freely

FILL_STACK 
ST R7,R7STORE
AND R7,R7,#0
ADD R7,R7,#-1
ADD R6,R6,#-1 ;R6 point to the top of the stack
STR R7,R6,#0 ;store #-1 to the stack,serving as a marker
ADD R6,R6,#-1 ;increase the stack top pointer(backward)

LEA R7,REG_COPY
STR R1,R7,#1

FILL_LOOP ;fill nodes into the stack
ADD R1,R1,#0 ;use set cc to detect whether the contents of R1 is negative
BRn RECOVER_REG
STR R1,R6,#0
ADD R6,R6,#-1 ;the top of the stack will move backward
LD R7,NODE ;R7 pointes to the node table
ADD R7,R7,R1 ;the precessdor nodes's address, use to index
LDR R1,R7,#0;R1 will contain the current precessdor nodes
BRnzp FILL_LOOP

RECOVER_REG
ADD R6,R6,#1 ;beacuase R6 is already points to place where the node is -1 here I need to change it back to the stack top
LEA R7,REG_COPY
LDR R1,R7,#1
LD R7,R7STORE
RET

;the third subroutine 
;print the nodes on the stack to the display
;register table
;R0:contain the ASCII to be printed
;because I can't change R0 so I will make a copy of it
;R6:pointer points to the top of stack
;R7:temporary store


PRINT_PATH
ST R7,R7STORE
LEA R7,REG_COPY
STR R0,R7,#0

POP_STACK_LOOP
LDR R7,R6,#0 ;R7 contain the current nodes
BRn LINEFEEDPRINT ;sentinel value has been found
LD R0,ASCII_A
ADD R0,R0,R7 ;increase to the correct ASCII
OUT
ADD R6,R6,#1 ;decrease the stack top pointer
LDR R7,R6,#0 
BRn LINEFEEDPRINT ;the printed ASCII was the last nodes don't need ->
LD R0,ASCII_ARROW1
OUT
LD R0,ASCII_ARROW2
OUT
BRnzp POP_STACK_LOOP

LINEFEEDPRINT
LD R0,LINEFEED
OUT
ADD R6,R6,#1 ;pop the sentinel out of the stack

LEA R7,REG_COPY
LDR R0,R7,#0 ;recover the value of register0, which shouldn't be changed
LD R7,R7STORE
RET

NODE .FILL x5000 
ASCII_A .FILL x41
ASCII_ARROW1 .FILL x2D
ASCII_ARROW2 .FILL x3E
LINEFEED .FILL #10
REG_COPY .BLKW #7
R7STORE .BLKW #1


	.END