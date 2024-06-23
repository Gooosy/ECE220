        .ORIG x7000

        ; Heap indices for test graph #2 -- note that these inputs are designed for testing MP2 subroutines
        ; and are DELIBERATELY inconsistent so as to test various conditions.  Results may be unpredictable
        ; for other inputs, since the "heaps" represented do not obey the heap property.

	.FILL x0007	; node 0
	.FILL x0008
	.FILL x0009
	.FILL x000A
	.FILL x000B
	.FILL x000C
	.FILL x000D
	.FILL x000E
	.FILL x000F
	.FILL x0010

	.FILL x0011	; node 10
	.FILL x0012
	.FILL x0013
	.FILL x0014
	.FILL x0015
	.FILL xFFFF	; node 15 not in heap
	.FILL xFFFF	; node 16 not in heap
	.FILL xFFFF	; node 17 not in heap
	.FILL x0016
	.FILL x0017

	.FILL xFFFF	; node 20 not in heap
	.FILL xFFFF	; node 21 not in heap
	.FILL x0000
	.FILL x0001
	.FILL x0002
	.FILL x0003
	.FILL x0004
	.FILL x0005
	.FILL x0006
	.FILL xFFFF	; node 29 not in heap

        ; 30 nodes total

        .END

