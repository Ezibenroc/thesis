import execo
import execo_g5k as g5k

user = 'tocornebize'
site = 'grenoble'
cluster = 'dahu'
nodes = 2
time = '00:20:00'
image = 'debian9-x64-base'

if __name__ == '__main__':
    query = "{cluster in ('%s')}/nodes=%d,walltime=%s" % (cluster, nodes, time)
    [(jobid, site)] = g5k.oarsub([(g5k.OarSubmission(resources=query, job_type='deploy'), site)])
    if jobid:
        print('Created job %d' % jobid)
        g5k.wait_oar_job_start(jobid, site)
        node_list = g5k.get_oar_job_nodes(jobid, site)
        g5k.deploy(g5k.Deployment(node_list, env_name=image), check_timeout=180)
        print('Terminated deployment')
        execo.Remote('apt update -qq', node_list).run()
        execo.Remote('DEBIAN_FRONTEND=noninteractive apt install -qq -y build-essential make git cmake',
                node_list).run()
        execo.Remote('git clone https://github.com/RoaringBitmap/CRoaring.git CRoaring &&\
                cd CRoaring && git checkout v0.2.66', node_list).run()
        execo.Remote('cd CRoaring && mkdir -p build && cd build && cmake .. && make -j', node_list).run()
        print('Terminated installation')
        p = execo.Remote('cd CRoaring && ./build/benchmarks/real_bitmaps_benchmark ./benchmarks/realdata/census-income',
                node_list).run()
        for proc in p.processes:
            print(proc.host.address)
            print(proc.stdout)
        print('Terminated experiment')
        g5k.oardel([(jobid, site)])
