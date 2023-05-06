#!/bin/sh

set -e

cleanup_docker=0
cleanup_image=0
cleanup() {
  if [ "$cleanup_docker" -ne 0 ]; then
    echo "Stopping Docker image"
    docker stop test
  fi


  if [ "$cleanup_image" -ne 0 ]; then
    echo "Removing Docker image"
    docker image rm testimage
  fi
}

trap cleanup EXIT

echo "Building Docker image"
time docker build -t testimage -f test/Dockerfile --build-arg "IMAGE=${CI_REGISTRY_IMAGE}:${TAG}" test
cleanup_image=1

echo "Running Docker image"
docker run -d --name test --rm -p 80:80 testimage
cleanup_docker=1

echo "Sleeping"
sleep 5

echo "Testing"
ADDRESS="$(LC_ALL=C nslookup -type=a docker 2>/dev/null | sed -nr '/Name/,+1s|Address(es)?: *||p')"
echo "$ADDRESS site.test" >> /etc/hosts
cat /etc/hosts
ping -c 1 site.tet
wget -T 30 -q -O - http://site.test | grep -q '<title>Test site</title>'
