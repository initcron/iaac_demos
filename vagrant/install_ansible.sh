#!/bin/bash 

if [ ! -e /opt/.ansible_installed ]; then 

  echo "I: Install pre reqs for ansible...."
  sudo apt-get install -yq  software-properties-common

  echo "I: Setup ansible PPA for ubuntu..."
  sudo apt-add-repository ppa:ansible/ansible

  echo "I: Update package cache again to pull the index of packages  from ansible PPA..."
  sudo apt-get update

  echo "I: Install ansible now ..."
  sudo apt-get install -yq  ansible

  echo "I: Restrictive permissions for the private key..."
  sudo chmod 600 /home/vagrant/.ssh/id_rsa

  echo "I: Create a flag notifying ansible is been installed..."
  touch /opt/.ansible_installed

fi 

exit 0

