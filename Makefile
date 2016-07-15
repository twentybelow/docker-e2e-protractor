all: build run

build:
				docker build -t hortonworks/protractor-runner .

run:
				docker run -it --rm --name protractor-runner --env-file utils/testenv -v /Users/aszegedi/prj/uluwatutests/uluwatu-e2e-protractor:/protractor/project hortonworks/protractor-runner

.PHONY:
				all
