all: build run

build:
				docker build -t hortonworks/docker-e2e-protractor .

run:
				docker run -it \
				--rm \
				--name protractor-runner \
				--privileged \
				--net=host \
				--env-file utils/testenv \
				-v $(PWD):/protractor/project \
				hortonworks/docker-e2e-protractor e2e.conf.js

run-ci:
				./scripts/e2e-gui-test.sh

run-regression:
				docker run -it \
				--rm \
				--name protractor-runner \
				--privileged \
				--net=host \
				--env-file utils/testenv \
				-v $(PWD):/protractor/project \
				hortonworks/docker-e2e-protractor e2e.conf.js --suite regression

run-smoke:
				docker run -it \
				--rm \
				--name protractor-runner \
				--privileged \
				--net=host \
				--env-file utils/testenv \
				-v $(PWD):/protractor/project \
				hortonworks/docker-e2e-protractor e2e.conf.js --suite smoke

run-from-linux:
				docker run -it \
				--rm \
				--name protractor-runner \
				--privileged \
				--net=host \
				--env-file utils/testenv \
				-v /dev/shm:/dev/shm \
				-v $(PWD):/protractor/project \
				hortonworks/docker-e2e-protractor e2e.conf.js --suite smoke

.PHONY:
				all
