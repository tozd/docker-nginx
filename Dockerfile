FROM tozd/runit

EXPOSE 80/tcp

RUN apt-get update -q -q && \
 apt-get --no-install-recommends --yes --force-yes install nginx-full && \
 echo "daemon off;" >> /etc/nginx/nginx.conf
 
COPY ./etc /etc

