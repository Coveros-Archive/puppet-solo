#
# Initialize Puppet so we can install the custom modules site properly
# This installs the stuff such that Puppet has whatever it needs in order 
# to run the our custom manifests.
#
# Invoke this with:
#   sudo puppet apply --modulepath=`pwd`/modules manifests/install-puppet.pp
#
# NOTE: This does not include anything needed to install keys for ehiera/eyaml.
# See the hiera directory for more information.
#
# NOTE: This was initially implemented on RHEL 6.x, so there are some limitations
# on the versions that get installed by default.

# This gets rid of a warning:  allow_virtual parameter will be changing its default value
if versioncmp($::puppetversion,'3.6.1') >= 0 {
  $allow_virtual_packages = hiera('allow_virtual_packages',true)
  Package {
    allow_virtual => $allow_virtual_packages,
  }
}

package { "hiera":
  ensure => latest,
} ~>
  # Ruby gems sometimes get installed with 600 permission.
  exec { 'fix permission of ruby':
    command => "/bin/chmod -R a+rX /usr/lib/ruby/gems"
  }

# Augeas allows us to operate on config files
package { "augeas":
  ensure => "latest",
}

# NOTE: RHEL 6 hiera version does not work with newer than eyaml 2.0.0 because
# it fails to load 'hiera/filecache' for Ruby 1.8 which is installed. This
# in turn requires an early-enough version of highline.
package { 'highline':
  ensure => '1.6.21',
  provider => 'gem',
} -> 
package { "hiera-eyaml": 
  ensure => "2.0.0",
  provider => "gem",
} ~>
  exec { 'fix permissions of eyaml':
    command => "/bin/chmod -R a+rX /usr/bin/eyaml"
    }

package { "zip": }
package { "unzip": }

file { ["/etc/puppet", "/etc/puppet/secure", "/etc/puppet/secure/keys"]:
  ensure => directory,
  owner => 'root',
  group => 'root',
  mode => '0700'
}

notify { "key message:":
  withpath => false,
  loglevel => warning,
  message => "NOTE: you must unpack encrypted zip file puppet-hiera-keys.zip to /etc/puppet/secure/keys"
}

# EXAMPLE: Install Puppet modules that we need
exec { '/usr/bin/puppet module install puppetlabs-mysql' : }



