#!/bin/bash

Help()
{
   echo "Please put your argument using these options"
   echo
   echo "Syntax: ./run [-b|-d|-s|-l|-h]"
   echo "options:"
   echo "-b  Build the docker image"
   echo "-d  Deploy the service using docker-compose"
   echo "-s  Stop docker-compose"
   echo "-l  Deploy the service to k8s cluster"
   echo "-h  Help"
   echo
}

if [ $# -lt 1 ]
then
   echo
   echo "############ Created by Natannegara ^^v #############"
   echo "#####################################################"
   echo
   echo "to see more options, please run: "
   echo "./run.sh -h"
   echo

   exit 1
fi

while getopts ":bdslh" option; do
   case $option in
      b)
         if [ $# -lt 2 ]; then
            echo
            echo "specify the repository !"
            echo "for instance: "
            echo "./run.sh -b n1t1n1g1r1/devops-mif_images"
            echo
            exit 1
         fi
         echo "building image ---> $2:testing"
	      cd 01-php-app/
         docker build --network=host -t $2:testing .
         docker push $2:testing
         echo
         exit;;

      d)
         echo "deploying service in docker-compose"
         docker-compose -f ./02-docker-compose/docker-compose.yaml up -d
         exit;;
      s)
         echo "terminate services in docker-compose"
         docker-compose -f ./02-docker-compose/docker-compose.yaml down
         exit;;

      l)
         if [ $# -lt 2 ]; then
            echo
            echo "the complete comment should be like this"
            echo './run.sh -l $HELM_UNIT_NAME $HELM_CHART_NAME'
            # echo './run.sh -l $HELM_UNIT_NAME $HELM_CHART_NAME $NAMESPACE/REPOSITORY'
            echo
            exit 1
         fi
         echo "deploying service to k8s cluster"
         helm install $2 ./04-kubernetes/$3 
         #helm upgrade $2 ./04-kubernetes/$3 --set=image.repository=$4 --set=image.tag=testing
         exit;;

      h)
         Help
         exit;;

      \?)
         echo "Error: Invalid option"
         exit;;
   esac
done
