all: build run

build:
				docker build -t sequenceiq/protractor-runner .

run:
				docker run -it --rm --name protractor-runner --env-file utils/testenv -v /dev/shm:/dev/shm -v $(pwd):/protractor/project sequenceiq/protractor-runner

.PHONY:
				all
