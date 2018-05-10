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
