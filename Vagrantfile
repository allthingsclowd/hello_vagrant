Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  
  (0..2).each do |i|
    config.vm.define "server-#{i}" do |node|
      node.vm.network "private_network", ip: "192.168.0.2#{i}"
      node.vm.network "forwarded_port", guest: 80, host: "802#{i}"
      if "#{i}" == "2"
        node.vm.provision "shell", path: "database_install.sh"
      else
        node.vm.provision "shell", path: "webserver_install.sh"
      end
    end
  end
  
end