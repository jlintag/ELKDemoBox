# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  pref = YAML.load_file("config.yaml")
  if !pref.has_key?('32bit') or !pref.has_key?('memory')
    abort("Your config.yaml must specify a '32bit' and 'memory' setting.")
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = pref['proxyhttp']
    config.proxy.https    = pref['proxyhttps']
    config.proxy.no_proxy = "localhost,127.0.0.1,.example.com"
  end
  if pref['32bit']
    config.vm.box = "ubuntu/xenial32"
  else
    config.vm.box = "ubuntu/xenial64"
  end

  config.vm.network "forwarded_port", guest: 5601, host: 5601
  config.vm.network "forwarded_port", guest: 9200, host: 9200

  config.vm.provider :virtualbox do |vb|
    vb.name = "elasticBox"
    vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", pref["memory"]]
  end

  config.vm.provision "shell", path: "elasticsearch.sh"
  config.vm.provision "shell", path: "kibana.sh"
end
