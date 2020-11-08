# tozd/nginx

<https://gitlab.com/tozd/docker/nginx>

Available as:

* [`tozd/nginx`](https://hub.docker.com/r/tozd/nginx)
* [`registry.gitlab.com/tozd/docker/nginx`](https://gitlab.com/tozd/docker/nginx/container_registry)

## Description

Image providing [Nginx](http://nginx.org) HTTP server.

The intended use of this image is that it is extended for images which serve content over the HTTP.

When extending the image, you can put sites configuration files under `/etc/nginx/sites-enabled/` to add custom sites.

Alternatively, you can mount a volume into `/etc/nginx/sites-volume/` directory and provide sites there.

If the container is run behind a reverse HTTP proxy, you can set `SET_REAL_IP_FROM` environment variable
to configure proxy's IP address for Nginx to correctly resolve and log clients' IP addresses.

When you are extending this image, you can add a script `/etc/service/nginx/run.initialization`
which will be run at a container startup, after the container is initialized, but before the
Nginx daemon is run.

All images are rebuild daily to get any latest (security) updates from
the underlying distribution.
If you do the same in your image (which extends any of these images), you will
get those updates as well.
