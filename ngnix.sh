echo "Installing NGINX"
apt-get update
apt-get -y install nginx
# sh -c "echo -n 'kibanaadmin:' >> /etc/nginx/.htpasswd"
# sh -c "openssl passwd -apr1 >> /etc/nginx/.htpasswd"
echo "kibanaadmin:'openssl passwd -apr1'" | tee -a /etc/ngnix/htpasswd.users # | passwd newuser
echo 'server {
        listen 80;

        server_name mykibanapage.com;

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
ufw allow 'Nginx Full'