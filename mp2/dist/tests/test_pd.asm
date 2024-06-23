        .ORIG x3F80

	LD R1,BITS	; should not be touched by code (HALT will change!)
	LD R2,BITS
	LD R3,BITS
	LD R4,BITS
	LD R5,BITS
	LD R6,BITS

        ; set R0 value for PERCOLATE_DOWN in script before this code runs
        AND R7,R7,#0
	ADD R7,R7,#2
        STI R7,SUB_NUM
        LD R7,ENTRY
        JSRR R7
THEHALT HALT

SUB_NUM .FILL x3001
ENTRY   .FILL x3002
BITS	.FILL xBEEF

        .END
