#!/bin/bash
echo "Creating image"
if [ $# -ne 1 ];
    then echo "illegal number of parameters"
    exit 1
fi

BUILD_NUM=$1
echo "Running with BUILD_NUM=" $BUILD_NUM
docker build -t prajwol5667/ci:$BUILD_NUM .

if [  "$(docker ps -q -f name=t2)" ]; then
    if [ "$(docker ps -aq -f status=running -f name=t2)" ]; then
       echo "cleanup"
        docker stop t2
        docker rm t2
    fi
fi

docker run -d --name t2  --rm -p 8011:8080 prajwol5667/ci:$BUILD_NUM
