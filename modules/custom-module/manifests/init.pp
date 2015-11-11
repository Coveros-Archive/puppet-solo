#
# puppet module to install stuff 
#
# This is really just an example of some packages that we can install


class custom-module {

  package { "dos2unix":
    ensure => latest,
  }

  package { "telnet":
    ensure => latest,
  }

  $my_prop = hiera('my_property', 'default value')
  $secure_prop = hiera('secure_property', 'no value provided for secure_property')

  # Create a profile script to set git19 as the default
  file { "/tmp/sample.txt":
    ensure => file,
    content => template("custom-module/sample.txt.erb"),
    mode => '0644',
    owner => "root",
    group => "root", 
  }
  
}

  

    
