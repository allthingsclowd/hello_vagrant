# Vagrant Hello World Example
This repository contains my first attempt at creating a basic _Vagrantfile_ that has the following requirements :

 - 2 x webservers
 - 1 x database server
 - servers will have static ip addresses starting at .20

## Prerequisites
 - Install Vagrant on your laptop - https://www.vagrantup.com/docs/installation/ 
 Verify installation as follows:
 ``` bash
 vagrant --version
 ```
 - I'm using virtualbox as my provider for Vagrant so I needed to install virtualbox - https://www.virtualbox.org/wiki/Downloads
 Verify with
 ``` bash
 virtualbox --help
 ```

## Procedure
 - create a new directory to work in
 ``` bash
 mkdir hello_vagrant
 cd hello_vagrant
 ```
 - run the following command to make a default template (Vagrantfile) to work with
 ``` bash
vagrant init hashicorp/precise64
 ```
   this will contain lots of helpful comments, or if you don't want these comments then use the following command for a minimal file
``` bash
vagrant init -fm hashicorp/precise64
```
which creates the following basic vagrantfile
``` vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
end
```
- verify the basics are working before going any further
``` bash
vagrant up
```
this will take a few minutes if this is the first time to download the box, login with the following command
``` bash
vagrant ssh
```
 - reset the environment as follows before further development and testing
 ``` bash
vagrant destroy -f
 ```
Now that we've verified we can build a single box (server) let's build the required 3 servers by making the following change
 - example of a multi server vagrantfile
``` vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.define "web-server-1" do |firstserver|
  end

  config.vm.define "web-server-2" do |secondserver|
  end

  config.vm.define "database-server" do |thirdserver|
  end

end
```
The login process is slightly different this time - as there are multiple servers you need to provide the vm name 
``` bash
vagrant ssh database-server 
```
 - let's add the static addresses by adding the following line to each vm definition remembering to adjust the ip address as required
 ``` vagrantfile
 firstserver.vm.network "private_network", ip: "172.16.0.20"
 ```
  - now to provision some software within each of the vms the following simple inline approach can be used
  ``` vagrantfile
    firstserver.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get install -y nginx
     service nginx start
    SHELL
  ```
  These servers will now be able to communicate with each other and the host server however it's necessary to add port forwarding to communicate beyond the host server
  ``` vagrantfile
  firstserver.vm.network "forwarded_port", guest: 80, host: 8020
  ```
  This gives us the following completed and working Vagrantfile 
  ``` vagrantfile
  Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.define "web-server-1" do |firstserver|
    firstserver.vm.network "private_network", ip: "172.16.0.20"
    firstserver.vm.network "forwarded_port", guest: 80, host: 8020
    firstserver.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get install -y nginx
     service nginx start
    SHELL
  end

  config.vm.define "web-server-2" do |secondserver|
    secondserver.vm.network "private_network", ip: "172.16.0.21"
    secondserver.vm.network "forwarded_port", guest: 80, host: 8021
    secondserver.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get install -y nginx
     service nginx start
    SHELL
  end

  config.vm.define "database-server" do |thirdserver|
    thirdserver.vm.network "private_network", ip: "172.16.0.22"
    thirdserver.vm.network "forwarded_port", guest: 27017, host: 8022
    thirdserver.vm.provision "shell", inline: <<-SHELL
     apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
     echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
     apt-get update
     apt-get install -y mongodb-org
    SHELL
  end

end
```

The next step will be to refactor and remove duplication....eventually.

Let's first of all move the provision code into external script files called database_install.sh and webserver_install.sh and we would call them by changing the provision line as follows
``` code
thirdserver.vm.provision "shell", path: "database_install.sh"
```
Obviously adjust the provision script for the appropriate server.
We should also makes these scripts idempotent - using a basic technique here that's mentioned in the Vagrant 'Up and Running' O'Reilly book.
``` bash
#!/usr/bin/env bash

# Idempotency hack - if this file exists don't run the rest of the script
if [-f "/var/vagrant_this_script_has_run"]; then
    exit 0
fi

touch /var/vagrant_this_script_has_run
# Add actual install code here
.
.
.
```

