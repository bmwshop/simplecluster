softlayer-simplecluster
====================

This is a set of scripts to create simple clusters on SoftLayer.
I intentionally did not use any software orchestration tools (Chef, Puppet, etc) to demonstrate 
what is minimally required for making a cluster.

At this point, this is a fully working, albeit somewhat hacked together, set of scripts.

Ensure you have the SoftLayer CLI installed on your machine, then issue the git pull.

To create a new cluster, edit the globals file, e.g.
```
vi globals
```
Here you will find the desciption of the nodes, name of the key to use and the type of your cluster
At the moment, I have tested this only with hadoop v1
Once you are done simply run:
```
./make_cluster.sh
```

The structure of the code is not complicated.  It first creates the key, then uses this key to kick off provisioning for the master and slave nodes.  Once all nodes are provisions, it starts installing software running setup_nodes.sh script. the setup_node.sh script contains common elements that needs to be done on all nodes.  setup_nodes.sh, towards the end, adds some operations that are specific to master or slave nodes.

slaves.txt will contain the list of your slave nodes along with external and internal ip addresses.
master.txt contains the addresses of the master node.

To connect to the master node of your new cluster, run
```
./sshmaster.sh
```
Or, to connect to the master node as root, you do
```
./sshmasterroot.sh
```


To remove the cluster, similarly, you run

```
./unmake_cluster.sh
```
