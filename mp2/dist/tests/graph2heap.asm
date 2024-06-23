        .ORIG x7FFF

        ; Heap for test graph #2 -- note that these inputs are designed for testing MP2 subroutines
        ; and are DELIBERATELY inconsistent so as to test various conditions.  Results may be unpredictable
        ; for other inputs, since the "heaps" represented do not obey the heap property.

        .FILL #24       ; 24 nodes in heap

        .FILL #22       ; root

        .FILL #23       ; level 1
        .FILL #24

        .FILL #25       ; level 2
        .FILL #26
        .FILL #27
        .FILL #28

        .FILL #0        ; level 3
        .FILL #1
        .FILL #2
        .FILL #3
        .FILL #4
        .FILL #5
        .FILL #6
        .FILL #7

        .FILL #8        ; level 4
        .FILL #9
        .FILL #10
        .FILL #11
        .FILL #12
        .FILL #13
        .FILL #14
        .FILL #18
        .FILL #19

        .END

