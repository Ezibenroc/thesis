SUBROUTINE remap_x ! remap onto original Eulerian grid
    ...
    DO iy= -1, ny+2
        iym = iy - 1
        DO ix = -1, nx+2
            ixm = ix - 1
            ...
        END DO
    END DO
    ...
END SUBROUTINE remap_x
