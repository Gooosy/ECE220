.ORIG x3000

;the first subroutine perform arithmetic 
;register table:
;R0:input number
;R1:final result
;R2:temporary store the result
;R3:temporary store the immediate value
;R6:store the current value that should be add to the result initialize to x0001
;R7:shift register that help logical right shift (divide 2 and round down)
;R7 will be initialized to 0000 0000 0000 0010 
;because the right most bits will be discard

FIND_PARENT ;first subroutine
ST R7,R7STORE
LEA R7,REG_COPY
STR R2,R7,#2 ;store the number currently in register R2 to memory
AND R2,R2,#0 ;initialize R2 to x0000
STR R3,R7,#3 ;same as R2
STR R6,R7,#6 ;same
ADD R6,R2,#1 ;initialize R6 to x0001

ADD R1,R0,#-1 
AND R7,R7,#0
ADD R7,R7,#2 ;initialize R7


RIGHT_SHIFT ;loop
BRz STORE
AND R3,R1,R7
BRz LEFTSHIFT
ADD R2,R2,R6
LEFTSHIFT
ADD R6,R6,R6 ;left shift R6
ADD R7,R7,R7 ;left shift R7
BRnzp RIGHT_SHIFT

STORE
ADD R1,R2,#0 ;store the result back to R1
LEA R7,REG_COPY
LDR R2,R7,#2
LDR R3,R7,#3
LDR R6,R7,#6 ;store the initial value back to R2,R3,R7 that shouldn't be modified
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

FILL_STACK ;second subroutine
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
ADD R6,R6,#1 ;beacuase R6 is already points to place where the node is -1
	     ;here I need to change it back to the stack top
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



