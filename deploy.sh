#!/bin/bash


#
docker rm -vf $(docker ps -a -q)
docker rmi -f $(docker images -a -q)
docker builder prune --all --force

# create network 
docker network create lab9-network



# create volume

docker volume create lab9vol

# build images for flask + db 
docker build -t flaskapplab9 ./flask-app
docker build -t sqllab9 ./db

# run mysql container 
docker run -d --network lab9-network --name mysql --mount type=volume,source=lab9vol,target=/var/lib/mysql sqllab9

# add sleep? maybe?



# run flask app
docker run -d -e MYSQL_ROOT_PASSWORD="password" --network lab9-network --name flask-app flaskapplab9


# run nginx container 
docker run -d -p 80:80 --network lab9-network --name nginxlab9container --mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf nginx




docker ps -a

