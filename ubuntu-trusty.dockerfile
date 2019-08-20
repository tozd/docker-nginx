FROM tozd/runit:ubuntu-trusty

EXPOSE 80/tcp

ENV SET_REAL_IP_FROM=

VOLUME /etc/nginx/sites-volume
VOLUME /var/log/nginx

RUN apt-get update -q -q && \
 apt-get --no-install-recommends --yes --force-yes install nginx-full && \
 echo "daemon off;" >> /etc/nginx/nginx.conf && \
 sed -i 's/\/\$nginx_version//' /etc/nginx/fastcgi_params && \
 echo 'fastcgi_param SCRIPT_FILENAME $request_filename;' >> /etc/nginx/fastcgi_params

COPY ./etc /etc
