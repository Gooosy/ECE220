        .ORIG x6000

        ; Distances for test graph #2 -- note that these inputs are designed for testing MP2 subroutines
        ; and are DELIBERATELY inconsistent so as to test various conditions.  Results may be unpredictable
        ; for other inputs, since the "heaps" represented do not obey the heap property.

        .FILL #44       ; node 0
        .FILL #45
        .FILL #46
        .FILL #47
        .FILL #24
        .FILL #24
        .FILL #26
        .FILL #28
        .FILL #49
        .FILL #50

        .FILL #51       ; node 10
        .FILL #52
        .FILL #53
        .FILL #54
        .FILL #55
        .FILL x7FFF     ; node 15 not reachable
        .FILL #0        ; node 16 distance 0 but not in heap
        .FILL #10       ; node 17 distance 10 but not in heap
        .FILL #56
        .FILL #30

        .FILL x7FFF     ; node 20 not reachable
        .FILL #5        ; node 21 distance 5 but not in heap
        .FILL #30
        .FILL #40
        .FILL #20
        .FILL #43
        .FILL #40
        .FILL #22
        .FILL #25
        .FILL x7FFF     ; node 29 not reachable

        ; 30 nodes total

        .END

