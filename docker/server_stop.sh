#!/bin/bash
###########################################
## Docker 컨테이너 이름
CONTAINER_NAME = "your_container_name"

## 이미지 이름 (필요한 경우 이미지 태그도 포함)
IMAGE_NAME = "your_image_name:latest"

## 시도 횟수
ATTEMPTS = 4

## 슬립타임
SLEEP_TIME = 3
###########################################


docker stop ${CONTAINER_NAME}

# 컨테이너가 실행 중인지 확인
if [ $(docker ps --format '{{.Names}}' | grep -w ${CONTAINER_NAME}) ]; then
    # 종료 확인
    ATTEMPTS=5
    SLEEP_TIME=3
    for (( i=1; i<=ATTEMPTS; i++ )); do
        echo "Checking if container ${CONTAINER_NAME} is still running... Attempt $i"
        if [ $(docker ps --format '{{.Names}}' | grep -w ${CONTAINER_NAME}) ]; then
            echo "Container ${CONTAINER_NAME} is still running..."
            exit 0
        fi
        sleep ${SLEEP_TIME}
    done
      echo "Failed to stop container ${CONTAINER_NAME}."
# OS 리부트
else
  echo 'Rebooting the system...'
  sudo reboot
fi
