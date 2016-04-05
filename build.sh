#!/usr/bin/env bash

PACKAGE="nginx"

docker build --no-cache -t d3v0x/${PACKAGE} .

TAG=$(docker run --rm d3v0x/${PACKAGE} ls /var/db/pkg/www-servers/ | grep ${PACKAGE} | sed -e 's/[a-z]*-//')

docker tag -f d3v0x/${PACKAGE} d3v0x/${PACKAGE}:${TAG}

echo "Pushing ${PACKAGE}:${TAG}"

docker push d3v0x/${PACKAGE}
