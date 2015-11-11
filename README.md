
This a set of puppet scripts that are intended to be self-contained within a single Git
repository. It has a few basic requirements, then allows you to write puppet modules
and manifests to install/configure other things.

There are three basic steps to make this work.

1. Install basic pre-requisites
1. Run the 'puppet' installation manifests to install the rest of stuff we need
1. Run the custom modules that we actually want to work

Pre-requisites. You need a few things first.
* Git
* Puppet

On RHEL-based Linux (Centos, etc.), do these steps:

    sudo yum install puppet
	sudo yum install git
	
Then, clone this repository onto your machine.

BUG BUG BUG: Currently, this ONLY works if the the puppet repository is checked out in 
a very specific directory:

    mkdir -p /opt/software/puppet-modules
    cd /opt/software/puppet-modules
    git clone ...
	
This has to do with the way we are referencing the Hiera data files. 

Once that is done, you can run the Puppet manifest routines to fully configure the rest of software 
needed to run puppet, hiera, and supporting stuff.

    sudo puppet apply --modulepath=`pwd`/modules manifests/install-puppet.pp

NOTE: After that, you need to do the following to install the encryption keys necessary to use
e-yaml with hiera. Follow the directions in [hiera/README.md](./hiera/README.md) to do so.

    sudo puppet apply --modulepath=`pwd`/modules:/etc/puppet/modules --hiera_config `pwd`/hiera/hiera.yaml manifests/custom-site.pp

Note that it has includes both the default module path as well as the local self-contained modules.




