FROM registry.gitlab.com/tozd/docker/dinit:ubuntu-focal

EXPOSE 80/tcp

ENV SET_REAL_IP_FROM=

VOLUME /etc/nginx/sites-volume
VOLUME /var/log/nginx

RUN apt-get update -q -q && \
  apt-get --no-install-recommends --yes --force-yes install nginx-full && \
  echo "daemon off;" >> /etc/nginx/nginx.conf && \
  sed -i 's/\/\$nginx_version//' /etc/nginx/fastcgi_params && \
  sed -i 's/access_log/#access_log/' /etc/nginx/nginx.conf && \
  echo 'fastcgi_param SCRIPT_FILENAME $request_filename;' >> /etc/nginx/fastcgi_params && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache ~/.npm

COPY ./etc/nginx /etc/nginx
COPY ./etc/service/nginx /etc/service/nginx
