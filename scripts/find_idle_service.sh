#!/bin/bash

function find_idle_port()
{
    CURRENT_PORT=$(cat /home/ubuntu/service_url.inc | grep -Po '[0-9]+' | tail -1)

    if [ ${CURRENT_PORT} -eq 8081 ]; then
        echo "8082"
    elif [ ${CURRENT_PORT} -eq 8082 ]; then
        echo "8081"
    else
        echo "> No WAS is connected to nginx"
        exit 1
    fi
}

function find_idle_service_name()
{
    IDLE_PORT=$(find_idle_port)

    if [ ${IDLE_PORT} -eq 8081 ]
    then
      echo "service1"
    else
      echo "service2"
    fi
}