all: build run

build:
				docker build -t sequenceiq/protractor-runner-xenial .

run:
				docker run -it --rm --name protractor-runner-xenial --env-file utils/testenv -v $(PWD):/protractor/project sequenceiq/protractor-runner-xenial

.PHONY:
				all
