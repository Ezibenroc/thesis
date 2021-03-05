SUBROUTINE dm_x_bcs
    ...
    CALL MPI_SENDRECV(dm(nx-1, 0:ny+1), ny+2, mpireal, &
        proc_x_max, tag,dm(-1, 0:ny+1), ny+2, mpireal, &
        proc_x_min, tag, comm, status, errcode)
    ...
END SUBROUTINE dm_x_bcs
