# Install required Vagrant plugins
missing_plugins_installed = false
required_plugins = %w(vagrant-cachier vagrant-hostsupdater vagrant-hosts vagrant-vbguest)

required_plugins.each do |plugin|
  if !Vagrant.has_plugin? plugin
    system "vagrant plugin install #{plugin}"
    missing_plugins_installed = true
  end
end

# If any plugins were missing and have been installed, re-run vagrant
if missing_plugins_installed
  exec "vagrant #{ARGV.join(" ")}"
end

Vagrant.configure(2) do |config|
  
  config.vm.define "chef-server" do |server|
      server.vm.box = "ubuntu/xenial64"
      server.vm.hostname = "chef-server"
      server.vm.network :private_network, ip: "10.0.15.10"
      server.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
      end
      server.vm.provision :shell, path: "provision/chef-server.sh"
  end

  config.vm.define :lb do |lb|
      lb.vm.box = "centos/7"
      lb.vm.hostname = "lb"
      lb.vm.network :private_network, ip: "10.0.15.15"
      lb.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
      lb.vm.provision :chef_zero do |chef|
        chef.nodes_path = "nodes"
        chef.add_recipe "ohai"
      end
  end

  (1..2).each do |i|
    config.vm.define "web0#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "web0#{i}"
      node.vm.network :private_network, ip: "10.0.15.2#{i}"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
      node.vm.provision :chef_zero do |chef|
        chef.nodes_path = "nodes"
        chef.add_recipe "ohai"
      end
    end
  end
end

