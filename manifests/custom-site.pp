#
# Initialize a Jenkins site.
#
# Invoke:
#   sudo puppet apply --modulepath=`pwd`/modules --hiera_config `pwd`/hiera/hiera.yaml manifests/custom-site.pp
#

# This gets rid of a warning:  allow_virtual parameter will be changing its default value
if versioncmp($::puppetversion,'3.6.1') >= 0 {
  $allow_virtual_packages = hiera('allow_virtual_packages',true)
  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

include "custom-module"

