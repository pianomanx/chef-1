#!/bin/bash
apt update
apt install -y build-essential
apt install -y software-properties-common
apt install -y openssh-server
add-apt-repository --yes --update ppa:ansible/ansible
apt install -y ansible
ansible-galaxy role install arillso.sshd
ansible-galaxy role install stuvusIT.systemd-timesyncd
mkdir -p /run/sshd
