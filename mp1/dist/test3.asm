; Add this test code to the start of your file (just after .ORIG).
;
; Read the comments in this file to understand what it's doing and
; for ways that you can use this test code.
;
; After assembling mp1 AND table with lc3as, execute the test script by typing
;    lc3sim -s script3 > your_output
;
; You can then type
;    diff your_output out3
; to compare your code's output with ours.
;

	; point the stack to a stored path
	LEA 	R6,STACK

	; set a breakpoint here in the debugger, then use 'next' to
	; execute your subroutine and see what happens to the registers;
	; they're not supposed to change (except for R7)...
	JSR	PRINT_PATH

	; note that since we mostly care about the output, we can
	; simply look at it or diff it again the expected result
	; (in out3 in this case)

	; this trap changes register values, so it's not sufficient
	; to check that all of the registers are unchanged; HALT may
	; also lead to confusion because the register values differ
	; for other reasons (R7 differences, for example).
DONE	HALT

STACk	.FILL	x0005
	.FILL	x0000
	.FILL	x0006
	.FILL	x0002
	.FILL	x0003
	.FILL	x0001
	.FILL	x0007
	.FILL	x0009
	.FILL	x000B
	.FILL	x000F
	.FILL   xFFFF

; your code should go here ... don't forget .ORIG and .END

