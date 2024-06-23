; Add this test code to the start of your file (just after .ORIG).
; I'd put it in another file, but it's not easy to use labels
; across files.

; Read the comments in this file to understand what it's doing and
; for ways that you can use this test code.
;
; After assembling mp1 with lc3as, execute the test script by typing
;    lc3sim -s script1 > your_output
; (look at the script--it just loads mp1 with a file command, then
; continues execution; when the LC-3 halts, the script is finished,
; so the simulator halts).
;
; You can then type
;    diff your_output out1
; to compare your code's output with ours.
;

	; feeling lazy, so I'm going to set all of the bits to the same value
	LD	R1,BITS
	ADD	R2,R1,#0
	ADD	R3,R1,#0
	ADD	R4,R1,#0
	ADD	R5,R1,#0
	ADD	R6,R1,#0

	; let's try FIND_PARENT on 42 ... should produce floor((42-1)/2) = 20.
	LD	R0,INPUT

	; set a breakpoint here in the debugger, then use 'next' to
	; execute your subroutine and see what happens to the registers;
	; they're not supposed to change (except for R7)...
	JSR	FIND_PARENT

	; let's check the answer first... only R7 is free--we may want to verify that
	; other registers still contain "BITS"
	LD	R7,EXPECT
	NOT	R7,R7
	ADD	R7,R7,#1
	ADD	R7,R7,R1
	BRz	ANSWER_OK
	LEA	R0,ANSWER_WRONG
	PUTS
ANSWER_OK

	; we're short on human time to test your code, so we'll do 
	; something like the following instead (feel free to replicate)...
	LD	R7,INPUT
	NOT	R7,R7
	ADD	R7,R7,#1
	ADD	R0,R0,R7
	BRz	R0_OK
	LEA	R0,R0_BAD
	PUTS
R0_OK	
	LD	R7,BITS
	NOT	R7,R7
	ADD	R7,R7,#1
	ADD	R2,R2,R7
	BRz	R2_OK
	LEA	R0,R2_BAD
	PUTS
R2_OK	

	; this trap changes register values, so it's not sufficient
	; to check that all of the registers are unchanged; HALT may
	; also lead to confusion because the register values differ
	; for other reasons (R7 differences, for example).
	HALT

BITS	.FILL	xABCD	; something unusual
INPUT	.FILL	#42	; sample input
EXPECT	.FILL	#20	; expected output
ANSWER_WRONG	.STRINGZ "FIND_PARENT produced the wrong answer in R1!\n"
R0_BAD	.STRINGZ "FIND_PARENT changes R0!\n"
R2_BAD	.STRINGZ "FIND_PARENT changes R2!\n"

; your code should go here ... don't forget .ORIG and .END

