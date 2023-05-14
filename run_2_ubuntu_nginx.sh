#!/bin/bash
set -eoux pipefail

path=`readlink -f "${BASH_SOURCE:-$0}"`
DIRECTORY_OF_THIS_FILE=`dirname $path`

docker run --rm -p 8000:80 -v $DIRECTORY_OF_THIS_FILE/run_2_ubuntu_nginx.conf:/etc/nginx/nginx.conf:ro -v `pwd`:/usr/share/nginx/html:ro nginx
