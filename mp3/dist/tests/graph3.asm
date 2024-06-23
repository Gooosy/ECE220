	.ORIG x3FFE

	.FILL x00	; start at node 0 by default

	.FILL x04	; 4 nodes in graph

	.FILL x7FFF	; node 0 edges
	.FILL x01
	.FILL x03
	.FILL x05

	.FILL x7FFF	; node 1 edges
	.FILL x7FFF
	.FILL x7FFF
	.FILL x7FFF

	.FILL x7FFF	; node 2 edges
	.FILL x7FFF
	.FILL x7FFF
	.FILL x01

	.FILL x7FFF	; node 3 edges
	.FILL x7FFF
	.FILL x7FFF
	.FILL x7FFF

	.END
