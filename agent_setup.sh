#!/bin/bash

#sudo apt-get update
sudo mkdir -p  /vagrant/agent-data
sudo mkdir -p  /vagrant/agent-logs
#Elasticsearch setup
curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.5.1.deb
sudo dpkg -i elasticsearch-6.5.1.deb
sudo chmod 755 -R /etc/elasticsearch/
sudo cp /vagrant/elasticsearch/elasticsearch.yml /etc/elasticsearch/
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service

#Logstash setup
curl -L -O https://artifacts.elastic.co/downloads/logstash/logstash-6.5.1.deb
sudo dpkg -i logstash-6.5.1.deb
sudo chmod 755 -R /etc/logstash/
sudo cp -R /vagrant/logstash/* /etc/logstash/conf.d/

#sudo systemctl enable logstash.service
#sudo systemctl start logstash.service
sudo /usr/share/logstash/bin/logstash -f /etc/logstash/conf.d/filebeattest.conf &

curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.5.1-amd64.deb
sudo dpkg -i filebeat-6.5.1-amd64.deb

sudo /usr/share/filebeat/bin/filebeat -e -c /etc/logstash/conf.d/filebeat.yml &

#kibana setup
curl -L -O https://artifacts.elastic.co/downloads/kibana/kibana-6.5.1-amd64.deb
sudo dpkg -i kibana-6.5.1-amd64.deb

sudo cp -R /vagrant/kibana/kibana.yml /etc/kibana/

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service

curl -XGET http://localhost:9200