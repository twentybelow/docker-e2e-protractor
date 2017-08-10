#!/bin/bash -x
# -e  Exit immediately if a command exits with a non-zero status.
# -x  Print commands and their arguments as they are executed.

: ${URL:? required}
: ${TEST_SUITE:? required}
: ${ENVFILE:=./utils/testenv}

export TESTCONF=/protractor/project/e2e.conf.js

echo "Refresh the Test Runner Docker image"
docker pull hortonworks/docker-e2e-protractor

export TEST_CONTAINER_NAME=gui-e2e

echo "Checking stopped containers"
if [[ -n "$(docker ps -a -f status=exited -f status=dead -q)" ]]; then
  echo "Delete stopped containers"
  docker rm $(docker ps -a -f status=exited -f status=dead -q)
else
  echo "There is no Exited or Dead container"
fi

echo "Checking " $TEST_CONTAINER_NAME " container is running"
if [[ "$(docker inspect -f {{.State.Running}} $TEST_CONTAINER_NAME 2> /dev/null)" == "true" ]]; then
  echo "Delete the running " $TEST_CONTAINER_NAME " container"
  docker rm -f $TEST_CONTAINER_NAME
fi

URL_RESPONSE=$(curl -k --write-out %{http_code} --silent --output /dev/null $URL)
echo $URL " HTTP status code is: " $URL_RESPONSE
if [[ $URL_RESPONSE -ne 200 ]]; then
    echo $URL " Web GUI is not accessible!"
    RESULT=1
else
    docker run -i \
    --privileged \
    --rm \
    --name $TEST_CONTAINER_NAME \
    --env-file $ENVFILE \
    -v $(pwd):/protractor/project \
    -v /dev/shm:/dev/shm \
    hortonworks/docker-e2e-protractor protractor e2e.conf.js --suite $TEST_SUITE
    RESULT=$?
fi

exit $RESULT