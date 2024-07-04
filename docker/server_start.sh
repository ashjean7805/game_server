#!/bin/bash
###########################################
## Docker 컨테이너 이름
CONTAINER_NAME="your_container_name"

## 이미지 이름 (필요한 경우 이미지 태그도 포함)
IMAGE_NAME="your_image_name:latest"

## 마운트 타입
MOUNT_TYPE='bind'
#### bind : 바인드 타입

## 도커 바인드 마운트 볼륨 디렉토리
DOCKER_DIRECTORY='your_directory'
#### 추가적으로 바인드 일지 케이스문 처리가 필요함

## 컨테이너 디렉토리
CONTAINER_DIRECTORY='your_container_dicrectory'

## 시도 횟수
ATTEMPTS=4

## 슬립타임
SLEEP_TIME=3
###########################################

## 컨테이너가 이미 실행 중인지 확인
if [ $(docker ps --format '{{.Names}}' | grep -w ${CONTAINER_NAME}) ]; then
    echo "Container ${CONTAINER_NAME} is already running."
## 컨테이너가 중지 상태인지 확인
elif [ $(docker ps -a --format '{{.Names}}' | grep -w ${CONTAINER_NAME}) ]; then
    echo "Starting existing container ${CONTAINER_NAME}..."
    docker start ${CONTAINER_NAME}

    ## 실행 확인
    for (( i=1; i<=ATTEMPTS; i++ )); do
        echo "Checking if container ${CONTAINER_NAME} started... Attempt $i"
        if [ $(docker ps --format '{{.Names}}' | grep -w ${CONTAINER_NAME}) ]; then
            echo "Container ${CONTAINER_NAME} started successfully."
            ## 정상 종료
            exit 0
        fi
        sleep ${SLEEP_TIME}
    done
    echo "Failed to start container ${CONTAINER_NAME} after ${ATTEMPTS} attempts."
    ## 오류 종료
    exit 1
else
    ## 컨테이너가 존재하지 않으면 새로 생성
    echo "Creating and starting new container ${CONTAINER_NAME}..."
    ############################################
    ## Docker 게임별 커스텀 설정 부분
    sudo docker run \
        --detach \
        --name ${CONTAINER_NAME} \
        --mount type=${MOUNT_TYPE},source=${DOCKER_DIRECTORY},target=${CONTAINER_DIRECTORY} \
      ${IMAGE_NAME}
    ############################################

    # 생성 확인
    for (( i=1; i<=ATTEMPTS; i++ )); do
        echo "Checking if container ${CONTAINER_NAME} created and started... Attempt $i"
        if [ $(docker ps --format '{{.Names}}' | grep -w ${CONTAINER_NAME}) ]; then
            echo "Container ${CONTAINER_NAME} created and started successfully."
            ## 정상 종료
            exit 0
        fi
        sleep ${SLEEP_TIME}
    done
    echo "Failed to cheack creation or starting the container ${CONTAINER_NAME} after ${ATTEMPTS} attempts."
    ## 오류 종료
    exit 1
fi
