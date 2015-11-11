#
# puppet module to install stuff 
#
# This is really just an example of some packages that we can install


class custom-module {

  # Install git 1.9 EPEL package
  package { "git19":
    ensure => latest,
  }

  package { "dos2unix":
    ensure => latest,
  }

  package { "telnet":
    ensure => latest,
  }

  # Create a profile script to set git19 as the default
  file { "/etc/profile.d/git.sh":
    ensure => file,
    content => template("custom-module/git.sh.erb"),
    mode => '0755',
    owner => "root",
    group => "root", 
  }

  $my_prop = hiera('my_property', 'default value')
  $secure_prop = hiera('secure_property', 'no value provided for secure_property')
  
}

  

    
