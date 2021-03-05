void dm_x_bcs(int rank) {
    ...
    mpi->sendrecv(ny+2, sstmac::sw::mpytype::mpi_real,\
    proc_x_max, tag, ny+2, sstmac::sw::mpitype::mpi_real,\
    proc_x_min, tag, world(), stat);
    ...
}
