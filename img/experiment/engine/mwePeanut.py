import peanut

class MyExperiment(peanut.Job):
    def setup(self):
        self.apt_install('stress-ng')

    def run_exp(self):
        nb_cores = len(self.nodes.cores)
        self.nodes.run('stress-ng --cpu %d --metrics-brief --perf -t 6' % nb_cores)
