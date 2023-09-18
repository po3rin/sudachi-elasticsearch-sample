#!/bin/bash

set -ex

cd /usr/share/elasticsearch

# execute docker.elastic.co/elasticsearch/elasticsearch image original entrypoint
docker-entrypoint.sh
