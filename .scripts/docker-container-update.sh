#!/bin/bash
# Created by ChatGPT

# stop and remove all running containers
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)

# remove all unused images and volumes
docker image prune -af
docker volume prune -f

# pull the latest images for all services
docker-compose pull

# start all services
docker-compose up -d
