	.ORIG x3000

; ***** DO NOT MODIFY THIS CODE--YOU WILL WANT IT FOR TESTING, AND WE USE IT, TOO. *****
; ***** ALSO, DO NOT PUT ANYTHING IN FRONT OF IT WHEN YOU SUBMIT YOUR SOLUTION.    *****

	BRNzp STUDENT_CODE
SUB_NUM	.FILL x00
	; for testing individual functions, set SUB_NUM to index of desired subroutine in table of functions below
	ST R6,LF_R6
	ST R7,LEAPFROG
	LEA R7,SE
	LD R6,SUB_NUM
	ADD R7,R7,R6
	LDR R7,R7,#0
	LD R6,LF_R6
	JSRR R7
	LD R7,LEAPFROG
	RET
LEAPFROG .BLKW #1
LF_R6	 .BLKW #1
SE	.FILL SWAP_ELEMENTS
PU	.FILL PERCOLATE_UP
PD	.FILL PERCOLATE_DOWN
GC	.FILL GET_CLOSEST
STUDENT_CODE

;  ***** WRITE THE REQUIRED MP2 SUBROUTINES HERE *****
;  (also add a copy of your MP1 code to the bottom of the file)

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
	BRz PU_DONE
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
	BRn PU_DONE
	; Swaps heap elements in R0 and R1 (in heap and in heap index array).
	JSR SWAP_ELEMENTS
	ADD R0,R1,#0	; Try again with parent.
	BRnzp PU_NEXT

PU_DONE	LD R0,PU_R0	; Restore callee-saved registers.
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

;  ***** PUT A COPY OF YOUR MP1 CODE HERE *****

	.END
