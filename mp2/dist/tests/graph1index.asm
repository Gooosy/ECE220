        .ORIG x7000

        ; Heap indices for test graph #1 -- note that these inputs are designed for testing MP2 subroutines
        ; and are DELIBERATELY inconsistent so as to test various conditions.  Results may be unpredictable
        ; for other inputs, since the "heaps" represented do not obey the heap property.

	.FILL x0012
	.FILL x0018
	.FILL x0019
	.FILL xFFFF	; node 3 not in heap
	.FILL x0006
	.FILL x0005
	.FILL x0000
	.FILL x0008
	.FILL x0007
	.FILL x000F

	.FILL x0015
	.FILL xFFFF	; node 11 not in heap
	.FILL x0013
	.FILL x001E
	.FILL x000D
	.FILL x000E
	.FILL x0003
	.FILL x0010
	.FILL x0020
	.FILL x001F

	.FILL xFFFF	; node 20 not in heap
	.FILL x0011
	.FILL x0014
	.FILL x001A
	.FILL x001B
	.FILL x0001
	.FILL x0021
	.FILL xFFFF	; node 27 not in heap
	.FILL x0016
	.FILL x0017

	.FILL x001C
	.FILL x001D
	.FILL x0004
	.FILL x0002
	.FILL x0009
	.FILL x000A
	.FILL x000C
	.FILL x000B

        ; 38 nodes total

        .END

