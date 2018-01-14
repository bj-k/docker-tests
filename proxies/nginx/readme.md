Run container:
docker run --name nginx -p 80:80 -v /vagrant/nginx/conf/conf.d:/etc/nginx/conf.d -v /vagrant/nginx/data:/var/www -d nginx:1.13.8
