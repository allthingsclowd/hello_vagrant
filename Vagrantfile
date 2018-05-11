Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.define "web-server-1" do |firstserver|
    firstserver.vm.network "private_network", ip: "172.16.0.20"
    firstserver.vm.network "forwarded_port", guest: 80, host: 8020
    firstserver.vm.provision "shell", path: "webserver_install.sh"
  end

  config.vm.define "web-server-2" do |secondserver|
    secondserver.vm.network "private_network", ip: "172.16.0.21"
    secondserver.vm.network "forwarded_port", guest: 80, host: 8021
    secondserver.vm.provision "shell", path: "webserver_install.sh"
  end

  config.vm.define "database-server" do |thirdserver|
    thirdserver.vm.network "private_network", ip: "172.16.0.22"
    thirdserver.vm.network "forwarded_port", guest: 27017, host: 8022
    thirdserver.vm.provision "shell", path: "database_install.sh"
  end

end
