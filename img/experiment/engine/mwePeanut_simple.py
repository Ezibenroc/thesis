import peanut

user = 'tocornebize'
cluster = 'dahu'
nodes = 2
time = '00:20:00'
image = 'debian9-x64-base'

if __name__ == '__main__':
    job = peanut.Job.oarsub_cluster(username=user, cluster=cluster, nb_nodes=nodes, walltime=time, deploy=image)
    job.kadeploy()
    job.apt_install('build-essential', 'make', 'git', 'cmake')
    job.git_clone('https://github.com/RoaringBitmap/CRoaring.git', 'CRoaring', checkout='v0.2.66')
    job.nodes.run('mkdir -p build', directory='CRoaring')
    job.nodes.run('cmake .. && make -j', directory='CRoaring/build')
    output = job.nodes.run('./build/benchmarks/real_bitmaps_benchmark ./benchmarks/realdata/census-income',
            directory='CRoaring')
    for node, result in output.items():
        print(node.host)
        print(result.stdout)
