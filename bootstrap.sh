#!/bin/bash

curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.13.deb
sudo dpkg -i elasticsearch-5.6.13.deb
sudo chmod 755 -R /etc/elasticsearch

mkdir -p /vagrant/data
mkdir -p /vagrant/logs
cp /vagrant/elasticsearch.yml /etc/elasticsearch/config/
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service
