; Add this test code to the start of your file (just after .ORIG).
;
; Read the comments in this file to understand what it's doing and
; for ways that you can use this test code.
;
; After assembling mp1 AND table with lc3as, execute the test script by typing
;    lc3sim -s script2 > your_output
;
; You can then type
;    diff your_output out2
; to compare your code's output with ours.
;

	; set up the stack
	LD 	R6,STACK

	; let's get the path for node number 3 (node D).
	AND	R1,R1,#0
	ADD	R1,R1,#3

	; set a breakpoint here in the debugger, then use 'next' to
	; execute your subroutine and see what happens to the registers;
	; they're not supposed to change (except for R7)...
	JSR	FILL_STACK

	; we should have 5 nodes + 1 sentinel on the stack
	LD	R7,STACK
	NOT	R5,R6
	ADD	R5,R5,#1
	ADD	R7,R7,R5
	ADD	R7,R7,#-6
	BRz	STACK_LEN_OK
	LEA	R0,STACK_LEN_BAD
	PUTS
STACK_LEN_OK

	; make sure the sentinel is there
	LD	R7,STACK
	LDR	R5,R7,#-1
	BRn	SENTINEL_OK
	LEA	R0,SENTINEL_BAD
	PUTS
	BRnzp	DONE	; not safe to compare without sentinel (we could count, but I'm lazy)
SENTINEL_OK

	; now let's check the answer itself
	LEA	R2,ANSWER
CHECK_LOOP
	LDR	R1,R2,#0
	LDR	R7,R6,#0
	BRn	FOUND_SENTINEL	; found the sentinel
	NOT	R7,R7
	ADD	R7,R7,#1
	ADD	R1,R1,R7
	BRz	NODE_OK
	LEA	R0,NODE_WRONG
	PUTS
NODE_OK	ADD	R2,R2,#1
	ADD	R6,R6,#1
	BRnzp	CHECK_LOOP

FOUND_SENTINEL
	ADD	R6,R6,#1
	LD	R7,STACK
	NOT	R7,R7
	ADD	R7,R7,#1
	ADD	R7,R7,R6
	BRz	NOT_EARLY
	LEA	R0,EARLY_SENTINEL
	PUTS

NOT_EARLY
	; this trap changes register values, so it's not sufficient
	; to check that all of the registers are unchanged; HALT may
	; also lead to confusion because the register values differ
	; for other reasons (R7 differences, for example).
DONE	HALT

ANSWER	.FILL	x0005
	.FILL	x0000
	.FILL	x0006
	.FILL	x0002
	.FILL	x0003

STACK	.FILL STACKBASE
STACK_LEN_BAD	.STRINGZ "FILL_STACK pushed the wrong number of things!\n"
ANSWER_WRONG	.STRINGZ "FILL_STACK produced the wrong answer!\n"
SENTINEL_BAD	.STRINGZ "FILL_STACK did not place a sentinel correctly!\n"
NODE_WRONG	.STRINGZ "FILL_STACK got a node value wrong!\n"
EARLY_SENTINEL	.STRINGZ "FILL_STACK put a sentinel in the middle of the path!\n"
	.BLKW #256
STACKBASE

; your code should go here ... don't forget .ORIG and .END

