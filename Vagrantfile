# frozen_string_literal: true

# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
PLAYBOOK = "infrastructure/ansible/playbook-development.yml"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "docker", primary: true do |docker|
    docker.vm.hostname = "role-based-access-control-docker"
    docker.vm.provision "shell", path: "bin/copy-ssh-key-to-docker-container", args: "docker"

    docker.vm.provision "shell", privileged: true, run: "always", inline: <<-SHELL
      chgrp vagrant /var/run/docker.sock
    SHELL

    docker.vm.provider :docker do |d|
      d.image = "svanosselaer/role-based-access-control-development"
      d.remains_running = true
      d.has_ssh = true
      d.pull = true
      d.create_args = [
        "-v", "//var/run/docker.sock:/var/run/docker.sock",
        "-v", "#{ENV["HOME"]}/.docker:/home/vagrant/.docker"
      ]
      d.cmd = [
        "/usr/sbin/sshd",
        "-D"
      ]
    end
  end

  config.vm.define "virtualbox" do |virtualbox|
    virtualbox.vm.box = "bento/debian-9"

    virtualbox.vm.hostname = "role-based-access-control-virtualbox"

    virtualbox.vm.synced_folder "#{Dir.home}/.docker", "/home/vagrant/.docker"

    virtualbox.vm.provision "ansible" do |ansible|
      ansible.playbook = PLAYBOOK
      ansible.compatibility_mode = "2.0"
      ansible.extra_vars = { ansible_python_interpreter: "/usr/bin/python" }
    end

    virtualbox.cache.scope = :machine if Vagrant.has_plugin?("vagrant-cachier")

    virtualbox.vm.provider :virtualbox do |vb|
      vb.cpus = 2
      vb.memory = 1024
    end
  end
end
