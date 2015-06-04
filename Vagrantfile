# -*- mode: ruby -*-
# vi: set ft=ruby :
nodes = {
  'controller' => [1, 11],
  'network' => [1, 21],
  'compute' => [1, 31]
}

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  # config.vm.box_url = https://atlas.hashicorp.com/ubuntu/trusty64

  nodes.each do |prefix, (count, ip_start)|
    count.times do |i|
      hostname = "%s" % [prefix, (i+1)]
      config.vm.define "#{hostname}" do |box|
        box.vm.hostname = "#{hostname}"
        # Management network
        box.vm.network :private_network, ip: "10.0.10.#{ip_start+i}", :netmask => "255.255.255.0"
        # Tunnel network
        if prefix == "network" || prefix == "compute"
          box.vm.network :private_network, ip: "10.0.11.#{ip_start+i}", :netmask => "255.255.255.0"
        end
        if prefix == "compute"
          box.vm.network :private_network, ip: "10.0.12.#{ip_start+i}", :netmask => "255.255.255.0"
        end

        # If using VirtualBox
        box.vm.provider :virtualbox do |vbox|
          vbox.customize ["modifyvm", :id, "--memory", 1024]
          if prefix == "compute"
            vbox.customize ["modifyvm", :id, "--memory", 3172]
            vbox.customize ["modifyvm", :id, "--cpus", 2]
          end
        end
      end
    end
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file = 'site.pp'
    puppet.module_path = 'manifests/modules'
  end
end
