
<h3> Running BEE-atified VPIC using Docker in AWS </h3>

**For Darwin instructions check out the darwin branch and see the BEE launcher https://github.com/randalburns/bee_launcher.git.**

Follow the DSS Viz Wiki instructions on configuring and starting a cluster https://darwin.lanl.gov/projects/vizproject/wiki/AWS-setup-notes and https://darwin.lanl.gov/projects/vizproject/wiki/Starcluster-notes.

Once a Starcluster Enviroment is configured (see below), running VPIC in AWS consists of logging into a StarCluster from your local machine. 
````
starcluster start -x <clustername>
starcluster sshmaster <clustername>
````
Then pulling the VPIC code from docker and configuring your parallel environment.
````
cd /home/vpic
git pull https://github.com/randalburns/vpicdocker.git
cd vpicdocker
mkdir -p ../vpicrun
````
Once logged into the StarCluster, you will need to edit _hostfile_ and _machinefile_ to reflect the topology of the cluster that you 
have launched.  _hostfile_ is in OpenMPI format and should have 1 slot per node and is used to launch docker on each node.
_machinefile_ should be in MPICH format and have one slot per core or virtual processor in AWS. Instructions for 
configuring parallelism are atj
https://darwin.lanl.gov/projects/virtualized-environments/wiki/Configuring_hostfile_and_machinefile.
Then pull the docker layers and run the code
````
mpirun -hostfile hostfile --mca btl_tcp_if_include eth0 ./mpibuild_vpic.sh --verbose 
mpirun -hostfile hostfile --mca btl_tcp_if_include eth0 ./mpirun_vpic.sh --verbose --output-filename=mpirun_vpic
````
   * --mca argument specifies to only use eth0 for mpi: otherwise openmpi tries to use docker0
   * this builds and runs the docker container vpic on each of the cluster nodes

Terminate the docker containers running the cluster.  This is run from the StarCluster shell, not inside the container.
````
mpirun -hostfile hostfile --mca btl_tcp_if_include eth0 ./mpistopcluster.sh --verbose
````


<h3> Interactive Launch </h3>
   
  * Test your installation with an interactive launch.  The following starts sshd on all the slave docker containers in the background, then launches a root bash shell on the master node docker container, and then runs the simulation.
````
mpirun -hostfile hostfile --mca btl_tcp_if_include eth0 ./mpirun_sshd.sh --verbose &
docker run -it --net=host -v /home/vpic/vpicrun:/mnt/vpicrun vpic /bin/bash
./launch.sh
````
Running docker with the _-it_ option gives you an interactive shell inside the container that you can use to edit and run codes.
If you invoke _..//launch.sh_ it runs the code with the default parameters.

  * Monitor the output -- from the virtual machine (not inside the container).  You will need another shell.
  
````
tail -f /home/vpic/vpicrun/.....
````

  * Terminate the docker containers running the cluster.  This is run from the StarCluster shell, not inside the container.
````
mpirun -hostfile hostfile --mca btl_tcp_if_include eth0 ./mpistopcluster.sh --verbose
````

<h3> Concepts </h3>

RBTODO talk about where the mount directories are and how the code runs.
 
