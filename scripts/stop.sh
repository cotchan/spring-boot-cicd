#!/bin/bash

CURRENT_PORT=$(cat /home/ubuntu/service_url.inc | grep -Po '[0-9]+' | tail -1)
IDLE_PORT=0

echo "> Current port of running WAS is ${CURRENT_PORT}."

if [ ${CURRENT_PORT} -eq 8081 ]; then
  IDLE_PORT=8082
elif [ ${CURRENT_PORT} -eq 8082 ]; then
  IDLE_PORT=8081
else
  echo "> No WAS is connected to nginx"
fi

echo "> $IDLE_PORT 에서 구동중인 애플리케이션 pid 확인"
IDLE_PID=$(sudo lsof -ti tcp:${IDLE_PORT})

if [ -z ${IDLE_PID} ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  echo "> kill -15 $IDLE_PID"   # Nginx에 연결되어 있지는 않지만 현재 실행 중인 jar 를 Kill 합니다.
  kill -15 ${IDLE_PID}
  sleep 5
fi