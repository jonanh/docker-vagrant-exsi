FROM ubuntu:latest

ARG VAGRANT_DOWNLOAD=https://releases.hashicorp.com/vagrant/2.1.5/vagrant_2.1.5_x86_64.deb

COPY VMware-ovftool-*.x86_64.bundle /packages/

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      curl \
      ca-certificates \
      openssh-client \
 # 
 # Install vagrant
 #
 && curl "${VAGRANT_DOWNLOAD}" -o /packages/vagrant.deb \
 && dpkg -i /packages/vagrant.deb \
 #
 # Install vagrant-vmware-esxi
 #
 && vagrant plugin install vagrant-vmware-esxi \
 # 
 # Install VMware ovftools
 #
 && chmod 755 /packages/VMware*.bundle \
 && /packages/VMware*.bundle --eulas-agreed --required \
 # 
 # Remove unnecessary packages and files
 # 
 && apt-get remove -y \
      curl \
      ca-certificates \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /packages

