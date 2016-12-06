echo "Installing Kibana"
echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get -y install kibana

# Append outside access restriction
#echo "network.host: localhost" >> /etc/elasticsearch/elasticsearch.yml

echo "Enabling Kibana in services"
sudo systemctl daemon-reload
sudo systemctl enable kibana
sudo systemctl start kibana