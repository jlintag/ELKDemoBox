echo "Installing NGINX"
PASSWORD='12345678'
apt-get update
apt-get -y install nginx
# sh -c "echo -n 'kibanaadmin:' >> /etc/nginx/.htpasswd"
# sh -c "openssl passwd -apr1 >> /etc/nginx/.htpasswd" 
echo "kibanaadmin:'openssl passwd -apr1'" | tee -a /etc/nginx/htpasswd.users
echo 'server {
        listen 80;

        server_name mykibanapage;

        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/htpasswd.users;

        location / {
            proxy_pass http://localhost:5601;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;        
        }
    }' >| /etc/nginx/sites-available/default
nginx -t
service nginx restart
# rm -Rf /var/www
# ln -s /vagrant /var/www
ufw allow 'Nginx Full'