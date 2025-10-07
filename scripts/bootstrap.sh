#!/bin/bash

apt update
apt install -y \
	build-essential \
	openssh-server \
	python3-pip \
        software-properties-common

pip install ansible
