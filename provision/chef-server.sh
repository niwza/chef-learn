#!/usr/bin/env bash

apt-get update -y -qq > /dev/null
apt-get upgrade -y -qq > /dev/null
apt-get -y -q install linux-headers-$(uname -r) build-essential curl > /dev/null

echo "Downloading the Chef server package..."
wget -nv -P /tmp https://packages.chef.io/files/stable/chef-server/12.17.5/ubuntu/16.04/chef-server-core_12.17.5-1_amd64.deb > /dev/null

echo "Installing Chef server..."
dpkg -i /tmp/chef-server-core_12.17.5-1_amd64.deb
chef-server-ctl reconfigure

echo "Waiting for services..."
until (curl -D - http://localhost:8000/_status) | grep "200 OK"; do sleep 15s; done
while (curl http://localhost:8000/_status) | grep "fail"; do sleep 15s; done

echo "Creating initial user and organization..."
chef-server-ctl user-create chefadmin Chef Admin chefadmin@testlab.com insecurepassword --filename /vagrant/.chef/chefadmin.pem
chef-server-ctl org-create testcheflab "Test Chef Lab" --association_user chefadmin --filename /vagrant/.chef/testcheflab.pem
chown -R ubuntu:ubuntu /vagrant
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license


echo "Your Chef server is ready!"