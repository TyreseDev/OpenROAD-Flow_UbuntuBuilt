#!/bin/bash

USERNAME="tyrese3915"

docker login -u ${USERNAME}
docker build -t ${USERNAME}/open-road-flow_ubuntu-built:20.04 .
docker tag ${USERNAME}/open-road-flow_ubuntu-built:20.04 ${USERNAME}/open-road-flow_ubuntu-built:20.04
docker push ${USERNAME}/open-road-flow_ubuntu-built:20.04