all: build

build:
				docker build -t sequenceiq/protractor-runner

run:
				docker run -it --rm --name uluwatu-e2e-runner --env-file <utils/testenv> -v /dev/shm:/dev/shm -v <protractor project location>:/protractor/project sequenceiq/protractor-runner
