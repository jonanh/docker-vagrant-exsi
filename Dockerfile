FROM ubuntu:latest

ARG VAGRANT_DOWNLOAD=https://releases.hashicorp.com/vagrant/2.1.5/vagrant_2.1.5_x86_64.deb

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      ca-certificates \
 && curl "${VAGRANT_DOWNLOAD}" -o vagrant.deb \
 && dpkg -i vagrant.deb \
 && rm vagrant.deb \
 && apt-get remove -y \
      curl \
      ca-certificates \
 && apt-get autoremove -y \
 && vagrant plugin install vagrant-vmware-esxi \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

