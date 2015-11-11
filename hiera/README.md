
This is the hiera configuration info that is needed to run my 'puppet-solo'
self-contained puppet recipes and properties. It contains a hiera.yaml 
configuration file, hiera value files, and a set of security keys needed
to make eYaml work. 

For eHiera and eYaml to work, you need to install these keys into a local directory
of /etc/puppet/secure/keys. For semi-secure convenience, I've packaged the keys into 
an encrypted ZIP file with a secret password. 

However, since this is a publically available tutorial and you have no way to fetch 
the secret password, I am including the password here:

Password: TotallyPublicCompromisedPassword

To install these keys and make eHiera work, do the following:

    sudo unzip -d /etc/puppet/secure/keys ./hiera/compromised-hiera-keys.zip
    sudo chmod -R 600 /etc/puppet/secure/keys/

TO MAKE THIS ACTUALLY SECURE, you need to regenerate a set of keys for yourself.
Run the following commands:

    sudo eyaml createkeys
	sudo chmod -R 600 /etc/puppet/secure/keys/
	sudo mv keys/* /etc/puppet/secure/keys

NOTE: To create the ZIP file of keys, I did the following:
   cd keys
   zip -e compromised-hiera-keys.zip *.pem
   
For more information, go check out https://github.com/TomPoulton/hiera-eyaml



