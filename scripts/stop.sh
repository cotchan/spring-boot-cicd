#!/bin/bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/find_idle_service.sh

IDLE_SERVICE=$(find_idle_service_name)

CONTAINER_ID=$(docker ps -f "name=${IDLE_SERVICE}" -q)

echo "> 컨테이너 ID는 무엇?? ${CONTAINER_ID}"
echo "> 현재 IDLE_SERVICE는 무엇?? ${IDLE_SERVICE}"

if [ -z ${CONTAINER_ID} ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  # 컨테이너 이름을 지정해서 사용하기 때문에 컨테이너 삭제도 필수
  echo "> docker stop ${IDLE_SERVICE}"
  sudo docker stop ${IDLE_SERVICE}
  echo "> docker rm ${IDLE_SERVICE}"
  sudo docker rm ${IDLE_SERVICE}
  sleep 5
fi