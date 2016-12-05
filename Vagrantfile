# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  pref = YAML.load_file("config.yaml")
  if !pref.has_key?('32bit') or !pref.has_key?('memory')
    abort("Your config.yaml must specify a '32bit' and 'memory' setting.")
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = pref['httproxy']
    config.proxy.https    = pref['httpsproxy']
    config.proxy.no_proxy = "localhost,127.0.0.1,.example.com"
  end

  config.vm.box = "elastic/ubuntu-14.04-x86_64"

  config.vm.provider :virtualbox do |vb|
    vb.name = "elasticBox"
    vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", pref["memory"]]
  end
end
