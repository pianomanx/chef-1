FROM ubuntu:latest
MAINTAINER Seth Kingry <sjkingry@gmail.com>

# Update my package repos
RUN apt-get -q update

# Install base packages
RUN apt-get install -y curl dialog git pipx python3 python3-pip ruby ruby-dev wget

RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pipx install awscli
ENV PATH=$PATH:/root/.local/bin

# Install user changing utility
COPY files/setuser /sbin
RUN chmod 755 /sbin/setuser
