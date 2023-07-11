# tozd/nginx

<https://gitlab.com/tozd/docker/nginx>

Available as:

- [`tozd/nginx`](https://hub.docker.com/r/tozd/nginx)
- [`registry.gitlab.com/tozd/docker/nginx`](https://gitlab.com/tozd/docker/nginx/container_registry)

## Image inheritance

[`tozd/base`](https://gitlab.com/tozd/docker/base) ← [`tozd/dinit`](https://gitlab.com/tozd/docker/dinit) ← `tozd/nginx`

## Tags

- `ubuntu-trusty`: nginx 1.4.6
- `ubuntu-xenial`: nginx 1.10.3
- `ubuntu-bionic`: nginx 1.14.0
- `ubuntu-focal`: nginx 1.18.0
- `ubuntu-jammy`: nginx 1.18.0

## Volumes

- `/var/log/nginx`: Log files when `LOG_TO_STDOUT` is not set to `1`.
- `/etc/nginx/sites-volume`: Nginx configuration for sites served by the container.

## Variables

- `SET_REAL_IP_FROM`: Configures [`set_real_ip_from`](https://nginx.org/en/docs/http/ngx_http_realip_module.html#set_real_ip_from)
  which defines trusted addresses that are known to send correct replacement addresses. If the container is run behind a reverse
  HTTP proxy, you can set this environment variable to configure proxy's IP address for Nginx to correctly resolve and log
  clients' IP addresses.
- `LOG_TO_STDOUT`: If set to `1` output logs to stdout (retrievable using `docker logs`) instead of log volumes.

## Ports

- `80/tcp`: HTTP port on which Nginx listens.

## Description

Image providing [Nginx](http://nginx.org) HTTP server.

The intended use of this image is that it is extended for images which serve content over the HTTP.

Access logs are formatted as JSON.
You can use defined `json` log format to format additional access logs as JSON as well.

When extending the image, you can put sites configuration files under `/etc/nginx/sites-enabled/` to add custom sites.

Alternatively, you can mount a volume into `/etc/nginx/sites-volume/` directory and provide sites there.

When you are extending this image, you can add a script `/etc/service/nginx/run.initialization`
which will be run at a container startup, after the container is initialized, but before the
Nginx daemon is run.

## GitHub mirror

There is also a [read-only GitHub mirror available](https://github.com/tozd/docker-nginx),
if you need to fork the project there.
