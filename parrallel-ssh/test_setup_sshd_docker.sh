#!/bin/bash

#run:  bash  parallel_sshd_docker.sh create 3
#run:  bash  parallel_sshd_docker.sh delete 3
# sudo docker port test_sshd 22
# 0.0.0.0:49154
#
# $ ssh root@localhost -p 49154
# The password is `root`
# reference : https://hub.docker.com/r/rastasheep/ubuntu-sshd/
# root@test_sshd $

pull(){
  docker pull rastasheep/ubuntu-sshd
}

create(){
  count=$1
  for ((i=1;i<=count;i++));
  do
    echo "creating docker test_sshd$i"
    docker run -d -P --name test_sshd"$i" rastasheep/ubuntu-sshd:14.04
  done
}

delete(){
  count=$1
  for ((i=1;i<=count;i++));
  do
    echo "deleting docker test_sshd$i"
    docker stop test_sshd"$i" 
    docker rm test_sshd"$i"
  done
}

# Check if the function exists (bash specific)
if declare -f "$1" > /dev/null
then
  # call arguments verbatim
  "$@"
else
  # Show a helpful error
  echo "'$1' is not a known function name" >&2
  exit 1
fi

