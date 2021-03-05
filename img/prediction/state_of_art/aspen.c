|\color{amblu}kernel| localFFT {
    |\color{amblu}exposes| parallelism [n^2]
    |\color{amblu}requires| flops [5 * n * log2(n)] |\color{amblu}as| dp, simd
    |\color{amblu}requires| loads [a * (n*wordSize) * max(1, log(
        n*wordSize)/log(z))] |\color{amblu}from| fftVolume
}
