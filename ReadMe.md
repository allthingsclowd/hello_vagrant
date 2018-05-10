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
Now that we've verified we can build a single box (server) let's build the required 3 servers by making the following change for multiple servers
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