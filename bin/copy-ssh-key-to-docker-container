#!/bin/bash

mkdir -p /home/vagrant/.ssh/
cp /vagrant/.vagrant/machines/$1/$1/private_key /home/vagrant/.ssh
chown vagrant: /home/vagrant/.ssh/private_key
chmod 600 /home/vagrant/.ssh/private_key
