        .ORIG x6000

        ; Distances for test graph #1 -- note that these inputs are designed for testing MP2 subroutines
        ; and are DELIBERATELY inconsistent so as to test various conditions.  Results may be unpredictable
        ; for other inputs, since the "heaps" represented do not obey the heap property.

        .FILL #12       ; node 0
        .FILL #14
        .FILL #24
        .FILL x7FFF     ; node 3 not reachable
        .FILL #25
        .FILL #18
        .FILL #7        ; node 6 ... the "root" of the example heap
        .FILL #12
        .FILL #14
        .FILL #15

        .FILL #18       ; node 10
        .FILL x7FFF     ; node 11 not reachable
        .FILL #16
        .FILL #21
        .FILL #10
        .FILL #15
        .FILL #12
        .FILL #18
        .FILL #20
        .FILL #19

        .FILL #0        ; node 20 distance 0 but not in heap
        .FILL #13
        .FILL #19
        .FILL #26
        .FILL #12
        .FILL #9
        .FILL #6
        .FILL #5        ; node 27 distance 5 but not in heap
        .FILL #20
        .FILL 18

        .FILL #25       ; node 30
        .FILL #19
        .FILL #10
        .FILL #7
        .FILL #15
        .FILL #17
        .FILL #20
        .FILL #12

        ; 38 nodes total

        .END

