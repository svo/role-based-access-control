# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
PLAYBOOK = "infrastructure/ansible/playbook-development.yml"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "development" do |development|
    development.vm.box = "bento/debian-9"

    development.vm.hostname = "role-based-access-control-development"

    development.vm.provision "ansible" do |ansible|
      ansible.playbook = PLAYBOOK
      ansible.compatibility_mode = "2.0"
      ansible.extra_vars = { ansible_python_interpreter: "/usr/bin/python" }
    end

    development.cache.scope = :machine if Vagrant.has_plugin?("vagrant-cachier")

    development.vm.provider :virtualbox do |vb|
      vb.cpus = 2
      vb.memory = 1024
    end
  end
end
