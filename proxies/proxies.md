NGINGX
https://www.nginx.com

Beginners Guide: http://nginx.org/en/docs/beginners_guide.html#conf_structure
Documentation: http://nginx.org/en/docs/

Config:
/etc/nginx/nginx.conf
/etc/nginx/conf.d/*.conf



Logs:
/var/log/nginx/access.log
/var/log/nginx/error.log

Commands:
Check config: nginx -t
Gracefully reload NGINX processes: nginx -s reload

Docker:
Container default root: /usr/share/nginx
Reload config: docker kill -s HUP <container name>

Docker Tips: https://blog.docker.com/2015/04/tips-for-deploying-nginx-official-image-with-docker/
Docker-Hub: https://hub.docker.com/_/nginx/


HAProxy
http://www.haproxy.org/


envoy
https://www.envoyproxy.io/
