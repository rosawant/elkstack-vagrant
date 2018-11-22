#!/bin/bash

#sudo apt-get update

#Elasticsearch setup
curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.13.deb
sudo dpkg -i elasticsearch-5.6.13.deb
sudo chmod 755 -R /etc/elasticsearch

cp /vagrant/configs/elasticsearch/elasticsearch.yml /etc/elasticsearch/
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service

#Logstash setup
curl -L -O https://artifacts.elastic.co/downloads/logstash/logstash-5.6.0.deb
sudo dpkg -i logstash-5.6.0.deb

cp -R /vagrant/configs/logstash/* /etc/logstash/conf.d/

sudo systemctl enable logstash.service
sudo systemctl start logstash.service

#kibana setup
curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-5.6.0-amd64.deb
sudo dpkg -i kibana-5.6.0-amd64.deb

cp /vagrant/configs/kibana/kibana.yml /etc/kibana/

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service

curl -XGET http://localhost:9200