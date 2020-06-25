#!/bin/bash

#checks whether deployment is already running
status=$(sudo kubectl get deployments my-dep) #searches for deployment
status=$? # assigns 1 ti status if pod not found

case $status in
              0)
              echo "Deployment online"
              exit 0
              ;;
            esac 
             
              
#checks whether PVC already created
status=$(sudo kubectl get pvc web-pvc) #searches for pvx
status=$? # assigns 1 ti status if pvc not found

case $status in 
      1)
      echo "Claiming Storage..."
      sudo kubectl create -f web-pvc.yml
      echo "creating svc..."
      sudo kubectl create -f test-svc.yml
      echo "All done!"
      ;;
      0)
      echo "PVC and SVC running..."
      ;;
   esac


#searches for index index file
status=$(sudo [ -f './index.html' ])
status=$?

case  $status  in
              
   0) #executes if index.html found
   echo "html code detected"
   echo "launching html server..."
   sudo kubectl create -f html-Deployment-test.yml
   echo "exposing server..."
   echo "EXPOSED!!!"
              ;;
    1) #executes if index.html note found
   echo "php code detected"
   echo "launching php server..."
   sudo kubectl create -f php-Deployment-test.yml
   echo "exposing server..."   
   echo "EXPOSED!!!"
              ;;
    esac

#NOTE: As of now, this code assumes that there are only two files html and php
#however, the code can be extended to accomodate more than two files