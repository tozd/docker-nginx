#!/bin/sh

set -e

cleanup_docker=0
cleanup_image=0
cleanup() {
  set +e

  if [ "$cleanup_docker" -ne 0 ]; then
    echo "Logs"
    docker logs test

    echo "Stopping Docker image"
    docker stop test
    docker rm -f test
  fi

  if [ "$cleanup_image" -ne 0 ]; then
    echo "Removing Docker image"
    docker image rm -f testimage
  fi
}

trap cleanup EXIT

echo "Building Docker image"
time docker build -t testimage -f test/Dockerfile --build-arg "IMAGE=${CI_REGISTRY_IMAGE}:${TAG}" test
cleanup_image=1

echo "Running Docker image"
docker run -d --name test -e LOG_TO_STDOUT=1 -e "SET_REAL_IP_FROM=0.0.0.0/0, ::/0" -p 80:80 testimage
cleanup_docker=1

echo "Sleeping"
sleep 5

echo "Testing"
ADDRESS="$(getent hosts docker | awk '{print $1}')"
echo "$ADDRESS site.test" >> /etc/hosts
wget -T 30 -q -O - http://site.test | grep -q '<title>Test site</title>'
# All addresses are trusted, so with real_ip_recursive the left-most address is used
# (without it, the right-most address would be used).
REMOTE_ADDR="$(wget -T 30 -q -O - --header 'X-Forwarded-For: 192.0.2.1, 203.0.113.7' http://site.test/remote-addr)"
if [ "$REMOTE_ADDR" != "192.0.2.1" ]; then
  echo "Unexpected remote address: $REMOTE_ADDR"
  exit 1
fi
echo "Success"
