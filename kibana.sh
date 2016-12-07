echo "Installing Kibana"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list
apt-get update
apt-get -y install kibana

# Replace outside access restriction
sed -i 's/server.host:\"0.0.0.0\"/server.host:\"localhost\"' /opt/kibana/config/kibana.yml

echo "Enabling Kibana in services"
update-rc.d kibana defaults 95 10
service kibana start