#!/usr/bin/env ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|

  # Vagrant Box
  config.vm.box = 'macos-sierra'
  config.vm.hostname = 'osx-test'
  config.vm.synced_folder ".", "/vagrant", disabled: true


  config.vm.provider :virtualbox do |vb|
    vb.memory = "4096"
    vb.cpus = "2"

    if RUBY_PLATFORM =~ /darwin/
      vb.customize ["modifyvm", :id, "--audio", "none", "--cpuidset", "00000001", "000306a9", "00020800", "80000201", "178bfbff"]
    end
  end

end
