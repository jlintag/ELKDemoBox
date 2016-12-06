echo "Installing Kibana"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list
apt-get update
apt-get -y install kibana

# Append outside access restriction
#echo "network.host: localhost" >> /etc/elasticsearch/elasticsearch.yml

echo "Enabling Kibana in services"
update-rc.d kibana defaults 95 10
service kibana start