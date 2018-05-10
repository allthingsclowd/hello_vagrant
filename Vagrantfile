Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"

  config.vm.define "web-server-1" do |firstserver|
    config.vm.network "private_network", ip: "172.16.0.20"
  end

  config.vm.define "web-server-2" do |secondserver|
    config.vm.network "private_network", ip: "172.16.0.21"
  end

  config.vm.define "database-server" do |thirdserver|
    config.vm.network "private_network", ip: "172.16.0.21"
  end

end
