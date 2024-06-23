        .ORIG x7FFF

        ; Heap for test graph #1 -- note that these inputs are designed for testing MP2 subroutines
        ; and are DELIBERATELY inconsistent so as to test various conditions.  Results may be unpredictable
        ; for other inputs, since the "heaps" represented do not obey the heap property.

        .FILL #34       ; 34 nodes in heap

        .FILL #6        ; root

        .FILL #25       ; level 1
        .FILL #33

        .FILL #16       ; level 2
        .FILL #32
        .FILL #5
        .FILL #4

        .FILL #8        ; level 3
        .FILL #7
        .FILL #34
        .FILL #35
        .FILL #37
        .FILL #36
        .FILL #14
        .FILL #15

        .FILL #9        ; level 4
        .FILL #17
        .FILL #21
        .FILL #0
        .FILL #12
        .FILL #22
        .FILL #10
        .FILL #28
        .FILL #29
        .FILL #1
        .FILL #2
        .FILL #23
        .FILL #24
        .FILL #30
        .FILL #31
        .FILL #13

        .FILL #19       ; level 5
        .FILL #18
        .FILL #26

        .END

