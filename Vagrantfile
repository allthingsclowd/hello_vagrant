Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.define "web-server-1" do |firstserver|
    firstserver.vm.network "private_network", ip: "172.16.0.20"
  end

  config.vm.define "web-server-2" do |secondserver|
    secondserver.vm.network "private_network", ip: "172.16.0.21"
  end

  config.vm.define "database-server" do |thirdserver|
    thirdserver.vm.network "private_network", ip: "172.16.0.22"
  end

end
