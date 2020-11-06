import peanut

class MyExperiment(peanut.Job):
    def setup(self):
        self.apt_install('build-essential', 'make', 'git', 'cmake')
        self.git_clone('https://github.com/RoaringBitmap/CRoaring.git', 'CRoaring', checkout='v0.2.66')
        self.nodes.run('mkdir -p build', directory='CRoaring')
        self.nodes.run('cmake .. && make -j', directory='CRoaring/build')

    def run_exp(self):
        output = self.nodes.run('./build/benchmarks/real_bitmaps_benchmark ./benchmarks/realdata/census-income',
                directory='CRoaring')
        for node, result in output.items():
            print(node.host)
            print(result.stdout)
