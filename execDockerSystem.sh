#!/bin/sh

echo "Start DockerFile build..."

if [[ $1 != "" ]]; then

  #statements
  echo "Paramter Succcess"

  echo "Docker image is searching..."

  imageList=($(docker image ls | grep -w $1))

  if  [ ! $imageList ]; then
    #statements
    echo 'no image match'
    echo 'docker build'
    docker network create --subnet=192.168.80.10 br0
    docker build -t $1 .
    echo 'docker build success'
    docker run -it $1 -h --net=br0 --ip=192.168.80.10 $1 /bin/bash
    echo 'docker container run'
    docker container run -it $1 /bin/bash
  else
    echo 'exist docker image'
    echo 'attach images'

    dockerStatus=($(docker ps -a | grep -w $1))

    if [[ $dockerStatus ]]; then

      containerImage=($(docker container ls | grep -w $1))

      if [[ $containerImage ]]; then
        echo 'attach attach'
        docker attach "${dockerStatus[0]}"
      else
        echo 'attach start'
        docker start "${dockerStatus[0]}"
        docker attach "${dockerStatus[0]}"
      fi
    else
      echo 'error'
    fi
  fi
else
  echo "build fails. no parameter: hint sh execDockerSystem.sh [imagename]"
fi
