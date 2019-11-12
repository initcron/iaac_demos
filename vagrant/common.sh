#!/bin/bash

if [ ! -e /opt/.common_done ]; then

  echo "I: Updating package cache..."
  sudo apt-get update

  echo "I: Install pre requisite packages...."
  sudo apt-get install -yq  python-minimal python-simplejson aptitude

  if [ -e /tmp/hosts ]; then
    echo "I: Copy hosts file to correct systems path.."
    sudo cp /tmp/hosts /etc/hosts
  fi

  if [ -e /home/ubuntu/.ssh/ansible_ssh_key.pub ]; then
    cat /home/ubuntu/.ssh/ansible_ssh_key.pub >> /home/ubuntu/.ssh/authorized_keys
  fi

  echo "I: Create a flag notifying common configs are done..."
  touch /opt/.common_done

fi

exit 0
