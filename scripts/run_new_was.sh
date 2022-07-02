#!/bin/bash

# 새로운 WAS를 띄우는 스크립트

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/find_idle_service.sh

SOURCE_REPOSITORY=/home/ubuntu/springboot-cicd

CURRENT_PORT=$(cat /home/ubuntu/service_url.inc | grep -Po '[0-9]+' | tail -1)

IDLE_SERVICE=$(find_idle_service_name)
TARGET_PORT=$(find_idle_port) # now idle_port is target_port for new_was

echo "> Current port of running WAS is ${CURRENT_PORT}."

CONTAINER_ID=$(docker ps -f "name=${IDLE_SERVICE}" -q)

if [ -z ${CONTAINER_ID} ]
then
  echo "> 현재 구동중인 애플리케이션이 없으므로 종료하지 않습니다."
else
  # 컨테이너 이름을 지정해서 사용하기 때문에 컨테이너 삭제도 필수
  echo "> docker stop ${IDLE_SERVICE}"
  sudo docker stop "${IDLE_SERVICE}"
  echo "> docker rm ${IDLE_SERVICE}"
  sudo docker rm "${IDLE_SERVICE}"
  sleep 5
fi

# 이름 설정해서 도커 이미지 빌드
docker build -t service $SOURCE_REPOSITORY

docker run -it --name "$IDLE_SERVICE" -d \
  -e PORT="$TARGET_PORT" \
  -e PROFILE="local" \
  -p "$TARGET_PORT":"$TARGET_PORT" \
  service

echo "> Now new WAS runs at ${TARGET_PORT}."
exit 0
