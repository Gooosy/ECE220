;---------------------------------------------------------------------------
; 
; WARNING!  This code was produced automatically using the ECE190 C compiler
; (MP5 in the Spring 2008 semester).  If you choose to modify it by hand,
; be aware that you WILL LOSE such changes when the code is recompiled.
;
; Student-generated code is marked as "STUDENT CODE."
;
;---------------------------------------------------------------------------

	.ORIG x3000

BOGUSFP
	LD	R4,GDPTR
	LEA	R5,BOGUSFP
	LD	R6,SPTR
	JSR	MAIN
	LEA	R0,OUTPREFIX
	PUTS
	LDR	R0,R6,#0
	ADD	R6,R6,#1
	LD	R1,PNPTR
	JSRR	R1
	AND	R0,R0,#0
	ADD	R0,R0,#10
	OUT
	HALT

GDPTR	.FILL GLOBDATA
SPTR	.FILL STACK
PNPTR	.FILL PRINT_NUM
OUTPREFIX	.STRINGZ "main returned "

MAIN	ADD	R6,R6,#-3
	STR	R5,R6,#0
	STR	R7,R6,#1
	ADD	R5,R6,#-1

;---------------------------------------------------------------------------
; local variable space allocation
;---------------------------------------------------------------------------

	ADD R6,R6,#-7

;---------------------------------------------------------------------------
; R0...R3 are callee-saved
;---------------------------------------------------------------------------

	ADD	R6,R6,#-4
	STR	R0,R6,#0	; save R0...R3
	STR	R1,R6,#1
	STR	R2,R6,#2
	STR	R3,R6,#3
	
;---------------------------------------------------------------------------
; STUDENT CODE STARTS HERE (after the symbol table)
;---------------------------------------------------------------------------

;                piles[3]        global          offset=+0
;                 seed           local to main   offset=+0
;                    i           local to main   offset=-1
;                    j           local to main   offset=-2
;                 done           local to main   offset=-3
;            choice_ok           local to main   offset=-4
;                 pnum           local to main   offset=-5
;                  amt           local to main   offset=-6
	LEA R3,LBL2
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL3
LBL2
	.STRINGZ "Please type a number: "
LBL3
	LD R3,LBL4
	JSRR R3
	BRnzp LBL5
LBL4
	.FILL PRINTF
LBL5
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	LD R3,LBL9
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL10
LBL9
	.FILL #1
LBL10
	AND R3,R3,#0
	ADD R0,R5,#0
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R3,LBL11
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL12
LBL11
	.STRINGZ "%d"
LBL12
	LD R3,LBL13
	JSRR R3
	BRnzp LBL14
LBL13
	.FILL SCANF
LBL14
	LDR R3,R6,#0
	ADD R6,R6,#2
	STR R3,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRz LBL8
	ADD R2,R2,#1
LBL8
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL16
	LD R3,LBL15
	JMP R3
LBL15
	.FILL LBL6
LBL16
	LEA R3,LBL17
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL18
LBL17
	.STRINGZ "That's not a number!\n"
LBL18
	LD R3,LBL19
	JSRR R3
	BRnzp LBL20
LBL19
	.FILL PRINTF
LBL20
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	LD R3,LBL21
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL22
LBL21
	.FILL #3
LBL22
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R5,#3
	;  LBL24
	LD R3,LBL23
	JMP R3
LBL23
	.FILL LBL1
LBL24
	;  LBL26
	LD R3,LBL25
	JMP R3
LBL25
	.FILL LBL7
LBL26
LBL6
LBL7
	AND R3,R3,#0
	ADD R0,R5,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LD R3,LBL27
	JSRR R3
	BRnzp LBL28
LBL27
	.FILL SRAND
LBL28
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	LD R3,LBL31
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL32
LBL31
	.FILL #0
LBL32
	AND R3,R3,#0
	ADD R0,R5,#-1
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
LBL29
	LD R3,LBL34
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL35
LBL34
	.FILL #3
LBL35
	AND R3,R3,#0
	ADD R0,R5,#-1
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnz LBL33
	ADD R2,R2,#1
LBL33
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL37
	LD R3,LBL36
	JMP R3
LBL36
	.FILL LBL30
LBL37
	LD R3,LBL38
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL39
LBL38
	.FILL #5
LBL39
	LD R3,LBL40
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL41
LBL40
	.FILL #10
LBL41
	LD R3,LBL42
	JSRR R3
	BRnzp LBL43
LBL42
	.FILL RAND
LBL43
	LDR R3,R6,#0
	ADD R6,R6,#0
	STR R3,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	ADD R6,R6,#2
	LD R3,LBL44
	JSRR R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL45
LBL44
	.FILL MODULUS
LBL45
	LDR R0,R6,#0
	LDR R1,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-1
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	AND R3,R3,#0
	ADD R0,R5,#-1
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R1,#0
	STR R0,R6,#0
	ADD R0,R0,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	;  LBL47
	LD R3,LBL46
	JMP R3
LBL46
	.FILL LBL29
LBL47
LBL30
	LD R3,LBL50
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL51
LBL50
	.FILL #0
LBL51
	AND R3,R3,#0
	ADD R0,R5,#-3
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
LBL48
	LD R3,LBL53
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL54
LBL53
	.FILL #0
LBL54
	AND R3,R3,#0
	ADD R0,R5,#-3
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL52
	ADD R2,R2,#1
LBL52
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL56
	LD R3,LBL55
	JMP R3
LBL55
	.FILL LBL49
LBL56
	LD R3,LBL59
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL60
LBL59
	.FILL #0
LBL60
	AND R3,R3,#0
	ADD R0,R5,#-1
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
LBL57
	LD R3,LBL62
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL63
LBL62
	.FILL #3
LBL63
	AND R3,R3,#0
	ADD R0,R5,#-1
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnz LBL61
	ADD R2,R2,#1
LBL61
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL65
	LD R3,LBL64
	JMP R3
LBL64
	.FILL LBL58
LBL65
	LD R3,LBL66
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL67
LBL66
	.FILL #1
LBL67
	AND R3,R3,#0
	ADD R0,R5,#-1
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#1
	STR R0,R6,#0
	LEA R3,LBL68
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL69
LBL68
	.STRINGZ "Pile %d: "
LBL69
	LD R3,LBL70
	JSRR R3
	BRnzp LBL71
LBL70
	.FILL PRINTF
LBL71
	LDR R3,R6,#0
	ADD R6,R6,#2
	STR R3,R6,#0
	ADD R6,R6,#1
	LD R3,LBL74
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL75
LBL74
	.FILL #0
LBL75
	AND R3,R3,#0
	ADD R0,R5,#-2
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
LBL72
	AND R3,R3,#0
	ADD R0,R5,#-1
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-2
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnz LBL76
	ADD R2,R2,#1
LBL76
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL78
	LD R3,LBL77
	JMP R3
LBL77
	.FILL LBL73
LBL78
	LEA R3,LBL79
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL80
LBL79
	.STRINGZ "*"
LBL80
	LD R3,LBL81
	JSRR R3
	BRnzp LBL82
LBL81
	.FILL PRINTF
LBL82
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	AND R3,R3,#0
	ADD R0,R5,#-2
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R1,#0
	STR R0,R6,#0
	ADD R0,R0,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	;  LBL84
	LD R3,LBL83
	JMP R3
LBL83
	.FILL LBL72
LBL84
LBL73
	LEA R3,LBL85
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL86
LBL85
	.STRINGZ "\n"
LBL86
	LD R3,LBL87
	JSRR R3
	BRnzp LBL88
LBL87
	.FILL PRINTF
LBL88
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	AND R3,R3,#0
	ADD R0,R5,#-1
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R1,#0
	STR R0,R6,#0
	ADD R0,R0,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	;  LBL90
	LD R3,LBL89
	JMP R3
LBL89
	.FILL LBL57
LBL90
LBL58
	LD R3,LBL93
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL94
LBL93
	.FILL #0
LBL94
	AND R3,R3,#0
	ADD R0,R5,#-4
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
LBL91
	LD R3,LBL96
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL97
LBL96
	.FILL #0
LBL97
	AND R3,R3,#0
	ADD R0,R5,#-4
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL95
	ADD R2,R2,#1
LBL95
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL99
	LD R3,LBL98
	JMP R3
LBL98
	.FILL LBL92
LBL99
	LEA R3,LBL100
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL101
LBL100
	.STRINGZ "From which pile will you take sticks? "
LBL101
	LD R3,LBL102
	JSRR R3
	BRnzp LBL103
LBL102
	.FILL PRINTF
LBL103
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	LD R3,LBL113
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL114
LBL113
	.FILL #1
LBL114
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R3,LBL115
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL116
LBL115
	.STRINGZ "%d"
LBL116
	LD R3,LBL117
	JSRR R3
	BRnzp LBL118
LBL117
	.FILL SCANF
LBL118
	LDR R3,R6,#0
	ADD R6,R6,#2
	STR R3,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRz LBL112
	ADD R2,R2,#1
LBL112
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL110
	LD R3,LBL120
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL121
LBL120
	.FILL #1
LBL121
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnz LBL119
	ADD R2,R2,#1
LBL119
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R2,R6,#0
	ADD R6,R6,#1
	ADD R2,R2,#0
	BRnp LBL110
	AND R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnp LBL111
LBL110
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
LBL111
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL108
	LD R3,LBL123
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL124
LBL123
	.FILL #3
LBL124
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRzp LBL122
	ADD R2,R2,#1
LBL122
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R2,R6,#0
	ADD R6,R6,#1
	ADD R2,R2,#0
	BRnp LBL108
	AND R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnp LBL109
LBL108
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
LBL109
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL106
	LD R3,LBL126
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL127
LBL126
	.FILL #0
LBL127
	LD R3,LBL128
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL129
LBL128
	.FILL #1
LBL129
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	ADD R6,R6,#1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL125
	ADD R2,R2,#1
LBL125
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R2,R6,#0
	ADD R6,R6,#1
	ADD R2,R2,#0
	BRnp LBL106
	AND R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnp LBL107
LBL106
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
LBL107
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL131
	LD R3,LBL130
	JMP R3
LBL130
	.FILL LBL104
LBL131
	LEA R3,LBL132
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL133
LBL132
	.STRINGZ "That's not a good choice.\n"
LBL133
	LD R3,LBL134
	JSRR R3
	BRnzp LBL135
LBL134
	.FILL PRINTF
LBL135
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	;  LBL137
	LD R3,LBL136
	JMP R3
LBL136
	.FILL LBL105
LBL137
LBL104
	LD R3,LBL138
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL139
LBL138
	.FILL #1
LBL139
	AND R3,R3,#0
	ADD R0,R5,#-4
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	LD R3,LBL140
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL141
LBL140
	.FILL #1
LBL141
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	ADD R6,R6,#1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
LBL105
	;  LBL143
	LD R3,LBL142
	JMP R3
LBL142
	.FILL LBL91
LBL143
LBL92
	LD R3,LBL146
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL147
LBL146
	.FILL #0
LBL147
	AND R3,R3,#0
	ADD R0,R5,#-4
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
LBL144
	LD R3,LBL149
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL150
LBL149
	.FILL #0
LBL150
	AND R3,R3,#0
	ADD R0,R5,#-4
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL148
	ADD R2,R2,#1
LBL148
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL152
	LD R3,LBL151
	JMP R3
LBL151
	.FILL LBL145
LBL152
	LD R3,LBL153
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL154
LBL153
	.FILL #1
LBL154
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#1
	STR R0,R6,#0
	LEA R3,LBL155
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL156
LBL155
	.STRINGZ "How many sticks will you take from pile %d? "
LBL156
	LD R3,LBL157
	JSRR R3
	BRnzp LBL158
LBL157
	.FILL PRINTF
LBL158
	LDR R3,R6,#0
	ADD R6,R6,#2
	STR R3,R6,#0
	ADD R6,R6,#1
	LD R3,LBL166
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL167
LBL166
	.FILL #1
LBL167
	AND R3,R3,#0
	ADD R0,R5,#-6
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R3,LBL168
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL169
LBL168
	.STRINGZ "%d"
LBL169
	LD R3,LBL170
	JSRR R3
	BRnzp LBL171
LBL170
	.FILL SCANF
LBL171
	LDR R3,R6,#0
	ADD R6,R6,#2
	STR R3,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRz LBL165
	ADD R2,R2,#1
LBL165
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL163
	LD R3,LBL173
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL174
LBL173
	.FILL #0
LBL174
	AND R3,R3,#0
	ADD R0,R5,#-6
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRn LBL172
	ADD R2,R2,#1
LBL172
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R2,R6,#0
	ADD R6,R6,#1
	ADD R2,R2,#0
	BRnp LBL163
	AND R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnp LBL164
LBL163
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
LBL164
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL161
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-6
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRzp LBL175
	ADD R2,R2,#1
LBL175
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R2,R6,#0
	ADD R6,R6,#1
	ADD R2,R2,#0
	BRnp LBL161
	AND R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnp LBL162
LBL161
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
LBL162
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL177
	LD R3,LBL176
	JMP R3
LBL176
	.FILL LBL159
LBL177
	LEA R3,LBL178
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL179
LBL178
	.STRINGZ "That's not a good choice.\n"
LBL179
	LD R3,LBL180
	JSRR R3
	BRnzp LBL181
LBL180
	.FILL PRINTF
LBL181
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	;  LBL183
	LD R3,LBL182
	JMP R3
LBL182
	.FILL LBL160
LBL183
LBL159
	LD R3,LBL184
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL185
LBL184
	.FILL #1
LBL185
	AND R3,R3,#0
	ADD R0,R5,#-4
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
LBL160
	;  LBL187
	LD R3,LBL186
	JMP R3
LBL186
	.FILL LBL144
LBL187
LBL145
	AND R3,R3,#0
	ADD R0,R5,#-6
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	ADD R6,R6,#1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	LD R3,LBL195
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL196
LBL195
	.FILL #0
LBL196
	LD R3,LBL197
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL198
LBL197
	.FILL #0
LBL198
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL194
	ADD R2,R2,#1
LBL194
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRz LBL192
	LD R3,LBL200
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL201
LBL200
	.FILL #0
LBL201
	LD R3,LBL202
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL203
LBL202
	.FILL #1
LBL203
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL199
	ADD R2,R2,#1
LBL199
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R2,R6,#0
	ADD R6,R6,#1
	ADD R2,R2,#0
	BRz LBL192
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnp LBL193
LBL192
	AND R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
LBL193
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRz LBL190
	LD R3,LBL205
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL206
LBL205
	.FILL #0
LBL206
	LD R3,LBL207
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL208
LBL207
	.FILL #2
LBL208
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL204
	ADD R2,R2,#1
LBL204
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R2,R6,#0
	ADD R6,R6,#1
	ADD R2,R2,#0
	BRz LBL190
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnp LBL191
LBL190
	AND R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
LBL191
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL210
	LD R3,LBL209
	JMP R3
LBL209
	.FILL LBL188
LBL210
	LEA R3,LBL211
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL212
LBL211
	.STRINGZ "You win!\n"
LBL212
	LD R3,LBL213
	JSRR R3
	BRnzp LBL214
LBL213
	.FILL PRINTF
LBL214
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	LD R3,LBL215
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL216
LBL215
	.FILL #1
LBL216
	AND R3,R3,#0
	ADD R0,R5,#-3
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	;  LBL218
	LD R3,LBL217
	JMP R3
LBL217
	.FILL LBL189
LBL218
LBL188
	LD R3,LBL221
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL222
LBL221
	.FILL #3
LBL222
	LD R3,LBL223
	JSRR R3
	BRnzp LBL224
LBL223
	.FILL RAND
LBL224
	LDR R3,R6,#0
	ADD R6,R6,#0
	STR R3,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	ADD R6,R6,#2
	LD R3,LBL225
	JSRR R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL226
LBL225
	.FILL MODULUS
LBL226
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
LBL219
	LD R3,LBL228
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL229
LBL228
	.FILL #0
LBL229
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL227
	ADD R2,R2,#1
LBL227
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL231
	LD R3,LBL230
	JMP R3
LBL230
	.FILL LBL220
LBL231
	LD R3,LBL232
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL233
LBL232
	.FILL #3
LBL233
	LD R3,LBL234
	JSRR R3
	BRnzp LBL235
LBL234
	.FILL RAND
LBL235
	LDR R3,R6,#0
	ADD R6,R6,#0
	STR R3,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	ADD R6,R6,#2
	LD R3,LBL236
	JSRR R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL237
LBL236
	.FILL MODULUS
LBL237
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	;  LBL239
	LD R3,LBL238
	JMP R3
LBL238
	.FILL LBL219
LBL239
LBL220
	LD R3,LBL240
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL241
LBL240
	.FILL #1
LBL241
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LD R3,LBL242
	JSRR R3
	BRnzp LBL243
LBL242
	.FILL RAND
LBL243
	LDR R3,R6,#0
	ADD R6,R6,#0
	STR R3,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	ADD R6,R6,#2
	LD R3,LBL244
	JSRR R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnzp LBL245
LBL244
	.FILL MODULUS
LBL245
	LDR R0,R6,#0
	LDR R1,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-6
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	LD R3,LBL246
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL247
LBL246
	.FILL #1
LBL247
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	ADD R0,R0,R1
	ADD R6,R6,#1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-6
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LEA R3,LBL248
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL249
LBL248
	.STRINGZ "I take %d from pile %d\n"
LBL249
	LD R3,LBL250
	JSRR R3
	BRnzp LBL251
LBL250
	.FILL PRINTF
LBL251
	LDR R3,R6,#0
	ADD R6,R6,#3
	STR R3,R6,#0
	ADD R6,R6,#1
	AND R3,R3,#0
	ADD R0,R5,#-6
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R0,R6,#0
	LDR R1,R6,#1
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	ADD R6,R6,#1
	STR R0,R6,#0
	AND R3,R3,#0
	ADD R0,R5,#-5
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	LD R3,LBL259
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL260
LBL259
	.FILL #0
LBL260
	LD R3,LBL261
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL262
LBL261
	.FILL #0
LBL262
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL258
	ADD R2,R2,#1
LBL258
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRz LBL256
	LD R3,LBL264
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL265
LBL264
	.FILL #0
LBL265
	LD R3,LBL266
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL267
LBL266
	.FILL #1
LBL267
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL263
	ADD R2,R2,#1
LBL263
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R2,R6,#0
	ADD R6,R6,#1
	ADD R2,R2,#0
	BRz LBL256
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnp LBL257
LBL256
	AND R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
LBL257
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRz LBL254
	LD R3,LBL269
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL270
LBL269
	.FILL #0
LBL270
	LD R3,LBL271
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL272
LBL271
	.FILL #2
LBL272
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R0,R4,#0
	ADD R0,R0,R3
	LDR R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	ADD R6,R6,#2
	AND R2,R2,#0
	NOT R1,R1
	ADD R1,R1,#1
	ADD R0,R0,R1
	BRnp LBL268
	ADD R2,R2,#1
LBL268
	ADD R6,R6,#-1
	STR R2,R6,#0
	LDR R2,R6,#0
	ADD R6,R6,#1
	ADD R2,R2,#0
	BRz LBL254
	AND R0,R0,#0
	ADD R0,R0,#1
	ADD R6,R6,#-1
	STR R0,R6,#0
	BRnp LBL255
LBL254
	AND R0,R0,#0
	ADD R6,R6,#-1
	STR R0,R6,#0
LBL255
	LDR R3,R6,#0
	ADD R6,R6,#1
	ADD R3,R3,#0
	BRnp LBL274
	LD R3,LBL273
	JMP R3
LBL273
	.FILL LBL252
LBL274
	LEA R3,LBL275
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL276
LBL275
	.STRINGZ "I win!\n"
LBL276
	LD R3,LBL277
	JSRR R3
	BRnzp LBL278
LBL277
	.FILL PRINTF
LBL278
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R6,#0
	ADD R6,R6,#1
	LD R3,LBL279
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL280
LBL279
	.FILL #1
LBL280
	AND R3,R3,#0
	ADD R0,R5,#-3
	ADD R0,R0,R3
	ADD R6,R6,#-1
	STR R0,R6,#0
	LDR R1,R6,#0
	LDR R0,R6,#1
	STR R0,R1,#0
	ADD R6,R6,#1
	ADD R6,R6,#1
	;  LBL282
	LD R3,LBL281
	JMP R3
LBL281
	.FILL LBL253
LBL282
LBL252
LBL253
LBL189
	;  LBL284
	LD R3,LBL283
	JMP R3
LBL283
	.FILL LBL48
LBL284
LBL49
	LD R3,LBL285
	ADD R6,R6,#-1
	STR R3,R6,#0
	BRnzp LBL286
LBL285
	.FILL #0
LBL286
	LDR R3,R6,#0
	ADD R6,R6,#1
	STR R3,R5,#3
	;  LBL288
	LD R3,LBL287
	JMP R3
LBL287
	.FILL LBL1
LBL288
LBL1

;---------------------------------------------------------------------------
; STUDENT CODE ENDS HERE
;---------------------------------------------------------------------------

	LDR	R0,R6,#0	; restore R0...R3
	LDR	R1,R6,#1
	LDR	R2,R6,#2
	LDR	R3,R6,#3

	ADD	R6,R5,#1	; pop off local variables
	LDR	R5,R6,#0
	LDR	R7,R6,#1
	ADD	R6,R6,#2	; leave return value on stack
	RET
	
;---------------------------------------------------------------------------
; C library routines
;---------------------------------------------------------------------------

; assembly routines in this library
;   MULTIPLY (R0 <- R0 * R1)
;   DIVIDE   (R0 <- R0 / R1, rounded toward 0)
;   MODULUS  (R0 <- R0 MOD R1, using C's definition)

; routines with C interfaces in this library
;   int PRINTF (const char* fmt, ...);
;   int SCANF (const char* fmt, ...);
;   void SRAND (int new_seed);
;   int RAND ();
; NOTES: 
;    - ALL C ROUTINES LEAVE A RETURN VALUE LOCATION ON THE STACK, EVEN
;      IF THEY PRODUCE NO RETURN VALUE!
;    - PRINTF and SCANF only handle %d, %%, \n, \\, and normal characters
;

; INTERNAL routines (you should not call them)
;   LOG_RIGHT_SHIFT
;   PRINT_NUM
;   LOAD_FORMAT
;

;---------------------------------------------------------------------------

; MULTIPLY -- calculate R0 * R1
;     INPUTS -- R0 and R1
;     OUTPUTS -- R0 is the product
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
MULTIPLY
	ADD R6,R6,#-3	; save R1, R2, and R3
	STR R1,R6,#0
	STR R2,R6,#1
	STR R3,R6,#2

	AND R2,R2,#0	; number of negative operands

	ADD R1,R1,#0	; set R1 to its absolute value
	BRzp MULT_R1_NON_NEG
	NOT R1,R1
	ADD R1,R1,#1
	ADD R2,R2,#1
MULT_R1_NON_NEG

	AND R3,R3,#0
MULT_LOOP
	ADD R1,R1,#0
	BRz MULT_FINISH
	ADD R3,R3,R0
	ADD R1,R1,#-1
	BRnzp MULT_LOOP

MULT_FINISH
	ADD R0,R3,#0	; move result into R0

	AND R2,R2,#1	; negate answer?
	BRz MULT_DONE
	NOT R0,R0
	ADD R0,R0,#1

MULT_DONE
	LDR R1,R6,#0	; restore R1, R2, and R3
	LDR R2,R6,#1
	LDR R3,R6,#2
	ADD R6,R6,#3
	RET


; DIVIDE -- calculate R0 / R1 (rounded toward zero)
;     INPUTS -- R0 and R1
;     OUTPUTS -- R0 is the quotient
;     SIDE EFFECTS -- uses stack to save registers; may print divide by
;                     zero error
;     NOTE: the calling convention here is NOT for use directly by C
;
DIVIDE	ADD R6,R6,#-4	; save R1, R2, R3, and R7
	STR R1,R6,#0
	STR R2,R6,#1
	STR R3,R6,#2
	STR R7,R6,#3

	AND R2,R2,#0	; number of negative operands
	ADD R2,R2,#1

	ADD R1,R1,#0	; set R1 to its negative absolute value
	BRn DIV_R1_NEG
	BRp DIV_R1_POS
	LEA R0,MSG_DIV
	PUTS
	AND R0,R0,#0
	BRnzp DIV_DONE
DIV_R1_POS
	NOT R1,R1
	ADD R1,R1,#1
	ADD R2,R2,#-1
DIV_R1_NEG

	ADD R0,R0,#0	; set R0 to its absolute value
	BRzp DIV_R0_NON_NEG
	NOT R0,R0
	ADD R0,R0,#1
	ADD R2,R2,#1
DIV_R0_NON_NEG

	AND R3,R3,#0
DIV_LOOP
	ADD R0,R0,R1
	BRn DIV_FINISH
	ADD R3,R3,#1
	BRnzp DIV_LOOP
DIV_FINISH
	ADD R0,R3,#0	; move result into R0

	AND R2,R2,#1	; negate answer?
	BRz DIV_DONE
	NOT R0,R0
	ADD R0,R0,#1

DIV_DONE
	LDR R1,R6,#0	; restore R1, R2, R3, and R7
	LDR R2,R6,#1
	LDR R3,R6,#2
	LDR R7,R6,#3
	ADD R6,R6,#4
	RET

MSG_DIV	.STRINGZ "\nDIVIDE BY ZERO\n"



; MODULUS -- calculate R0 MOD R1 (defined in C as R0 - (R0 / R1) * R1)
;     INPUTS -- R0 and R1
;     OUTPUTS -- R0 is the modulus
;     SIDE EFFECTS -- uses stack to save registers; may print divide by
;                     zero error
;     NOTE: the calling convention here is NOT for use directly by C
;
MODULUS	ADD R6,R6,#-3	; save R0, R1, and R7
	STR R0,R6,#0
	STR R1,R6,#1
	STR R7,R6,#2

	JSR DIVIDE	; R0 = R0 / R1
	JSR MULTIPLY	; R0 = (R0 / R1) * R1
	NOT R1,R0	; negate it
	ADD R1,R1,#1
	LDR R0,R6,#0	; add to original R0
	ADD R0,R0,R1

	LDR R1,R6,#1	; restore R1 and R7
	LDR R7,R6,#2
	ADD R6,R6,#3
	RET


; SRAND -- set random number generation seed
;     INPUTS -- new seed (on top of stack)
;     OUTPUTS -- one (meaningless) location left on top of stack
;     SIDE EFFECTS -- changes random seed
;     NOTE: call as a C function
;
SRAND	ADD R6,R6,#-1		; save R0
	STR R0,R6,#0
	LDR R0,R6,#1
	ST R0,RAND_SEED
	LDR R0,R6,#0		; restore R0
	RET


; LOG_RIGHT_SHIFT -- logically shift R0 right by one bit (MSB <- 0)
;     INPUTS -- R0
;     OUTPUTS -- R0 shifted right by a bit
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
LOG_RIGHT_SHIFT
	ADD R6,R6,#-1		; save R1
	STR R1,R6,#0

	AND R0,R0,xFFFE		; set low bit to 0 (will become MSB)

	AND R1,R1,#0		; loop 15 times...
	ADD R1,R1,#15

LRSHFT_LOOP
	ADD R0,R0,#0		; rotate left (copy high bit to low bit)
	BRn LOW_BIT_IS_1
	ADD R0,R0,R0
	BRnzp LRSHFT_NEXT
LOW_BIT_IS_1
	ADD R0,R0,R0
	ADD R0,R0,1

LRSHFT_NEXT
	ADD R1,R1,#-1
	BRp LRSHFT_LOOP

	LDR R1,R6,#0		; restore R1
	ADD R6,R6,#1
	RET


; RAND -- generate random number using the function
;             NEW = (27193 * OLD) + 35993   MOD 65536
;	  the low bit is right-shifted out before returning, since
;         it is not random (the rest are not too bad, at least by 
;         separation of order 2 in Knuth's methods...)
;     INPUTS -- none
;     OUTPUTS -- random value left on top of stack (return value)
;     SIDE EFFECTS -- changes random seed
;     NOTE: call as a C function
;
RAND	ADD R6,R6,#-3		; save R0, R1, and R7
	STR R0,R6,#0
	STR R1,R6,#1
	STR R7,R6,#2
	LD R0,RAND_SEED
	ADD R1,R0,R0		; x 0002
	ADD R1,R1,R0		; x 0003
	ADD R1,R1,R1		; x 0006
	ADD R1,R1,R1		; x 000C
	ADD R1,R1,R0		; x 000D
	ADD R1,R1,R1		; x 001A
	ADD R1,R1,R1		; x 0034
	ADD R1,R1,R0		; x 0035
	ADD R1,R1,R1		; x 006A
	ADD R1,R1,R1		; x 00D4
	ADD R1,R1,R1		; x 01A8
	ADD R1,R1,R1		; x 0350
	ADD R1,R1,R0		; x 0351
	ADD R1,R1,R1		; x 06A2
	ADD R1,R1,R0		; x 06A3
	ADD R1,R1,R1		; x 0D46
	ADD R1,R1,R0		; x 0D47
	ADD R1,R1,R1		; x 1A8E
	ADD R1,R1,R1		; x 351C
	ADD R1,R1,R1		; x 6A38
	ADD R0,R1,R0		; x 6A39 = #27193
	LD R1,RAND_ADD
	ADD R0,R0,R1
	ST R0,RAND_SEED
	JSR LOG_RIGHT_SHIFT	; drop the low bit
	LDR R7,R6,#2		; restore R7
	STR R0,R6,#2		; save return value onto stack
	LDR R0,R6,#0		; restore R0 and R1 
	LDR R1,R6,#1
	ADD R6,R6,#2
	RET

; storage for SRAND and RAND

RAND_SEED 
	.BLKW 1
RAND_ADD
	.FILL #35993


; PRINT_NUM -- print a number in decimal to the monitor (based on code 
;              incorporated as TRAP x26 for MP2 in the Spring 2004 
;              semester of ECE190)
;     INPUTS -- R0 is the number to be printed
;     OUTPUTS -- R0 is the number of characters printed
;     SIDE EFFECTS -- none
;     NOTE: the calling convention here is NOT for use directly by C
;
; The basic strategy is to handle the sign first, then to loop over place
; values starting from 10,000 down to 10.  Place values are subtracted
; repeatedly to calculate each digit, then digits are printed, with 
; leading zeroes omitted.

; R0 is the current digit (calculated in the inner loop)
; R1 points to table of negative digit place values
; R2 holds current digit's place value, again negative
; R3 is the remaining value after removing the previous digit
; R4 is a temporary
; R5 holds the ASCII value '0'
; R6 is a marker used to avoid leading zeroes

PRINT_NUM
	ST R1,PN_SAVE_R1	; callee saves registers
	ST R2,PN_SAVE_R2
	ST R3,PN_SAVE_R3
	ST R4,PN_SAVE_R4
	ST R5,PN_SAVE_R5
	ST R6,PN_SAVE_R6
	ST R7,PN_SAVE_R7

	AND R3,R0,#0		; initialize number of characters printed
	ST R3,PN_PRINTED

	ADD R3,R0,#0		; move to R3 and check for negative value
	BRzp PN_NON_NEG
	LD R0,PN_MINUS		; if negative, print a minus sign
	OUT
	LD R0,PN_PRINTED	; add one to printed characters count
	ADD R0,R0,#1
	ST R0,PN_PRINTED
	NOT R3,R3		; and replace R0 with its absolute value
	ADD R3,R3,#1		; (-32768 will be handled correctly, too)
PN_NON_NEG
	
	LEA R1,PN_SUB		; initialize pointer to place value table
	LD R5,PN_ASC_ZERO	; initialize register with ASCII '0'
	AND R6,R6,#0		; skip leading zeroes
PN_LOOP
	LDR R2,R1,#0		; load digit place value from table
	BRz PN_LAST_DIGIT	; end of table?
	AND R0,R0,#0		; start current digit at 0 (count ADDs)
PN_DIG_LOOP			; loop to determine digit value
	ADD R4,R3,R2		; subtract place value once
	BRn PN_DIG_DONE		; done?
	ADD R3,R4,#0		; no, so copy to remaining value
	ADD R0,R0,#1		;   and increment digit
	BRnzp PN_DIG_LOOP
PN_DIG_DONE
	ADD R4,R0,R6		; do not print leading zeroes
	BRz PN_NO_PRINT
	ADD R0,R0,R5		; print current digit
	OUT
	LD R0,PN_PRINTED	; add one to printed characters count
	ADD R0,R0,#1
	ST R0,PN_PRINTED
	ADD R6,R6,#1		; always print subsequent digits, even zeroes
PN_NO_PRINT
	ADD R1,R1,#1		; point to next place value
	BRnzp PN_LOOP		; loop back for next digit
PN_LAST_DIGIT
	ADD R0,R3,R5		; always print last digit
	OUT
	LD R0,PN_PRINTED	; add one to printed characters count
	ADD R0,R0,#1

	LD R1,PN_SAVE_R1	; restore original register values
	LD R2,PN_SAVE_R2
	LD R3,PN_SAVE_R3
	LD R4,PN_SAVE_R4
	LD R5,PN_SAVE_R5
	LD R6,PN_SAVE_R6
	LD R7,PN_SAVE_R7
	RET

PN_SAVE_R1 .BLKW 1		; space for caller's register values
PN_SAVE_R2 .BLKW 1
PN_SAVE_R3 .BLKW 1
PN_SAVE_R4 .BLKW 1
PN_SAVE_R5 .BLKW 1
PN_SAVE_R6 .BLKW 1
PN_SAVE_R7 .BLKW 1
PN_PRINTED .BLKW 1

PN_SUB  .FILL #-10000		; table of place values
	.FILL #-1000
	.FILL #-100
	.FILL #-10
	.FILL #0

PN_ASC_ZERO .FILL x30		; '0'
PN_MINUS    .FILL x2D		; '-'


; LOAD_FORMAT -- load a character from a format string (for PRINTF or
;		 SCANF), translating escape sequences (-1 for %d)
;                and advancing the string pointer appropriately
;     INPUTS -- R1 is the format string pointer
;     OUTPUTS -- R0 is the next character (-1 for %d)
;                R1 is advanced either one or two locations
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
LOAD_FORMAT
	ADD R6,R6,#-2	; save R2 and R3
	STR R2,R6,#0
	STR R3,R6,#1
	LDR R0,R1,#0
	LD R2,LDF_TEST_1
	ADD R3,R0,R2
	BRnp LDF_NOT_PCT
	LDR R0,R1,#1
	ADD R2,R0,R2
	BRnp LDF_CHECK_D
	ADD R1,R1,#1
LDF_BAD_PCT
	LDR R0,R1,#0
	BRnzp LDF_DONE
LDF_CHECK_D
	LD R2,LDF_TEST_2
	ADD R0,R0,R2
	BRnp LDF_BAD_PCT
	AND R0,R0,#0
	ADD R0,R0,#-1
	ADD R1,R1,#1
	BRnzp LDF_DONE
LDF_NOT_PCT
	LD R2,LDF_TEST_3
	ADD R3,R0,R2
	BRnp LDF_DONE
	LDR R0,R1,#1
	ADD R2,R0,R2
	BRnp LDF_CHECK_N
	ADD R1,R1,#1
LDF_BAD_BS
	LDR R0,R1,#0
	BRnzp LDF_DONE
LDF_CHECK_N
	LD R2,LDF_TEST_4
	ADD R0,R0,R2
	BRnp LDF_BAD_BS
	AND R0,R0,#0
	ADD R0,R0,#10
	ADD R1,R1,#1
LDF_DONE
	ADD R1,R1,#1	; default string pointer advance
	LDR R2,R6,#0	; restore R2 and R3
	LDR R3,R6,#1
	ADD R6,R6,#2
	RET

LDF_TEST_1 	.FILL xFFDB	; -'%'
LDF_TEST_2	.FILL xFF9C	; -'d'
LDF_TEST_3	.FILL xFFA4	; -'\\'
LDF_TEST_4	.FILL xFF92	; -'n'


; PRINTF -- print formatted data
;     INPUTS -- format string followed by arguments
;     OUTPUTS -- number of characters printed left on top of stack 
;                (return value)
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: call as a C function
;
; R0 holds the character to print
; R1 is the format string pointer
; R2 points to the next argument
; R3 is the number of characters printed so far
;
PRINTF	ADD R6,R6,#-5		; save R0, R1, R2, R3, and R7
	STR R0,R6,#0
	STR R1,R6,#1
	STR R2,R6,#2
	STR R3,R6,#3
	STR R7,R6,#4
	LDR R1,R6,#5
	ADD R2,R6,#6
	AND R3,R3,#0
PR_LOOP	JSR LOAD_FORMAT
	ADD R0,R0,#0
	BRz PR_DONE
	BRp PR_REG
	LDR R0,R2,#0
	ADD R2,R2,#1
	JSR PRINT_NUM
	ADD R3,R3,R0
	BRnzp PR_LOOP
PR_REG	OUT
	ADD R3,R3,#1
	BRnzp PR_LOOP
PR_DONE	LDR R7,R6,#4		; restore R7
	STR R3,R6,#4		; save return value
	LDR R0,R6,#0		; restore R0, R1, R2, and R3
	LDR R1,R6,#1
	LDR R2,R6,#2
	LDR R3,R6,#3
	ADD R6,R6,#4
	RET


; BUF_GETC -- read a character from the keyboard, with preference for
;                a character previously read but buffered (in INBUF)
;     INPUTS -- none
;     OUTPUTS -- R4 holds the character
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
BUF_GETC
	ADD R6,R6,#-2
	STR R0,R6,#0
	STR R7,R6,#1
	LD R4,INBUF
	BRnp BGC_OLD
	GETC
	OUT
	ADD R4,R0,#0
	BRnzp BGC_DONE
BGC_OLD	LD R0,INBUF2
        ST R0,INBUF
	AND R0,R0,#0
	ST R0,INBUF
BGC_DONE
	LDR R0,R6,#0
	LDR R7,R6,#1
	ADD R6,R6,#2
	RET

; BUF_UNGETC -- push a character back into the input buffer
;     INPUTS -- R4 holds the character
;     OUTPUTS -- none
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;
BUF_UNGETC
	ADD R6,R6,#-1
	STR R0,R6,#0
	LD R0,INBUF
	ST R0,INBUF2
	ST R4,INBUF
	LDR R0,R6,#0
	ADD R6,R6,#1
	RET

; READ_NUM -- read a decimal number from the keyboard, starting with
;             a character previously read but buffered (in INBUF) if necessary;
;             skip white space before the first digit; terminate on non-digit
;             (after first digit); buffer character that causes termination;
;             ignore overflow
;             (this code based on readnumsub.asm code from 190 materials)
;     INPUTS -- none
;     OUTPUTS -- R4 holds the number typed in; R0 holds 1 if number was typed,
;                or 0 if not
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: the calling convention here is NOT for use directly by C
;

; R0 is used as a temporary register
; R1 holds the current value of the number being input
; R2 holds the additive inverse of ASCII '0' (0xFFD0)
; R3 is used as a temporary register
; R4 holds the value of the last key pressed
; R5 marks whether a digit has been seen (positive), just a negative sign (-),
;    or nothing has been seen (0) yet

READ_NUM
	ADD R6,R6,#-5		; save R1, R2, R3, R5, and R7
	STR R1,R6,#0
	STR R2,R6,#1
	STR R3,R6,#2
	STR R5,R6,#3
	STR R7,R6,#4
	AND R1,R1,#0		; clear the current value
	LD R2,RN_NEG_0		; put the value -x30 in R2
	AND R5,R5,#0		; no digits yet
	ST R5,RN_NEGATE
READ_LOOP
	JSR BUF_GETC
	ADD R0,R4,R2		; subtract x30 from R4 and store in R0 
	BRn RN_NON_DIG		; smaller than '0' means a non-digit
	ADD R3,R0,#-10		; check if > '9'
	BRzp RN_NON_DIG		; greater than '9' means a non-digit
	ADD R5,R4,#0		; a digit has been seen
	ADD R3,R1,R1		; sequence of adds multiplies R1 by 10
	ADD R3,R3,R3
	ADD R1,R1,R3
	ADD R1,R1,R1
	ADD R1,R1,R0		; finally, add in new digit
	BRnzp READ_LOOP		; get another digit
RN_NON_DIG
	; if we see space, tab, CR, or LF, we consume if no digits have
	; been seen; otherwise, we stop and buffer the character
	AND R0,R0,#0
	ADD R5,R5,#0
	BRp RN_GOT_NUM 
	BRz RN_NO_DIGITS

	; need to put the minus sign back, too
	JSR BUF_UNGETC
	LD R4,RN_MINUS
	BRnzp RN_SAVE_CHAR

RN_NO_DIGITS
	ADD R3,R4,#-9
	BRz READ_LOOP
	ADD R3,R4,#-10
	BRz READ_LOOP
	ADD R3,R4,#-13
	BRz READ_LOOP
	ADD R3,R4,#-16
	ADD R3,R3,#-16
	BRz READ_LOOP

	LD R3,RN_NEG_MIN
	ADD R3,R3,R4
	BRnp RN_SAVE_CHAR
	ADD R5,R5,#-1
	ST R5,RN_NEGATE
	BRnzp READ_LOOP

RN_GOT_NUM
	ADD R0,R0,#1
	LD R5,RN_NEGATE
	BRz RN_SAVE_CHAR
	NOT R1,R1
	ADD R1,R1,#1
RN_SAVE_CHAR
	JSR BUF_UNGETC
	ADD R4,R1,#0		; move R1 into R4	
	LDR R1,R6,#0		; restore R1, R2, R3, R5, and R7
	LDR R2,R6,#1
	LDR R3,R6,#2
	LDR R5,R6,#3
	LDR R7,R6,#4
	ADD R6,R6,#5
	RET

RN_NEG_0	.FILL xFFD0	; -'0'
RN_NEG_MIN	.FILL xFFD3	; -'-'
RN_MINUS	.FILL x002D	; '-'
RN_NEGATE	.BLKW 1

; SCANF -- scan in formatted data
;     INPUTS -- format string followed by arguments
;     OUTPUTS -- number of integers converted left on top of stack 
;                (return value)
;     SIDE EFFECTS -- uses stack to save registers
;     NOTE: call as a C function
;
; R0 holds the character to be read
; R1 is the format string pointer
; R2 points to the next argument
; R3 is the number of integer conversions so far
; R4 is the character/number actually read from the keyboard
;
SCANF	ADD R6,R6,#-6		; save R0, R1, R2, R3, R4, and R7
	STR R0,R6,#0
	STR R1,R6,#1
	STR R2,R6,#2
	STR R3,R6,#3
	STR R4,R6,#4
	STR R7,R6,#5
	LDR R1,R6,#6
	ADD R2,R6,#7
	AND R3,R3,#0
SC_LOOP	JSR LOAD_FORMAT
	ADD R0,R0,#0
	BRz SC_DONE
	BRp SC_REG
	JSR READ_NUM
	ADD R0,R0,#0
	BRz SC_DONE
	LDR R0,R2,#0
	ADD R2,R2,#1
	STR R4,R0,#0
	ADD R3,R3,#1
	BRnzp SC_LOOP
SC_REG	JSR BUF_GETC
	NOT R0,R0
	ADD R0,R0,#1
	ADD R0,R0,R4
	BRz SC_LOOP
	JSR BUF_UNGETC
SC_DONE	LDR R7,R6,#5		; restore R7
	STR R3,R6,#5		; save return value
	LDR R0,R6,#0		; restore R0, R1, R2, R3, and R4
	LDR R1,R6,#1
	LDR R2,R6,#2
	LDR R3,R6,#3
	LDR R4,R6,#4
	ADD R6,R6,#5
	RET

; buffered input characters (0 means none)
INBUF	.FILL x0000
INBUF2	.FILL x0000

;---------------------------------------------------------------------------
; global data space allocation
;---------------------------------------------------------------------------

GLOBDATA
	.BLKW #3

;---------------------------------------------------------------------------
; stack allocation
;---------------------------------------------------------------------------

	.BLKW #1000
STACK

	.END

