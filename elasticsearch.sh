#! /bin/bash

apt-get install apt-transport-https

echo "Installing Java 8"
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get -y install oracle-java8-installer

echo "Installing Elasticsearch"
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
# wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
# echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list
apt-get update
apt-get -y install elasticsearch

# Append outside access restrict
echo 'network.host: "localhost"' >> /etc/elasticsearch/elasticsearch.yml

echo "Enabling Elasticsearch in services"
update-rc.d elasticsearch defaults 95 10
service elasticsearch start