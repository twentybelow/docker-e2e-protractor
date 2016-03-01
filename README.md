# About
Docker image for executing test cases in a Docker container from [ULUWATU functional E2E tests](https://github.com/sequenceiq/uluwatu-e2e-protractor) test project.

The [Dockerfile](Dockerfile) was design based on the following projects:
- [Protractor and headless Chrome on Docker](http://float-middle.com/protractor-and-headless-chrome-on-docker-with-video-tutorial/) or [Docker image of Protractor with headless Chrome](https://github.com/jciolek/docker-protractor-headless)
- [docker-protractor](https://github.com/School-Improvement-Network/docker-protractor)

# Docker Run
1. Clone this repository.
2. Build the [Docker image](https://docs.docker.com/engine/reference/commandline/build/#tag-image-t).
3. Provide valid and appropriate values for base test parameters in the [environment file](utils/testenv). The following variables should be set:
  - BASE_URL=`https://pre-prod-accounts.sequenceiq.com/`
  - USERNAME=`testing@something.com`
  - PASSWORD=`password`
  - IAMROLE=`arn:aws:iam::1234567890:role/userrole`
  - SSHKEY=`AAAAB3NzaC1+soon...etc.`
4. Open the local folder where the [ULUWATU functional E2E tests](https://github.com/sequenceiq/uluwatu-e2e-protractor) project has been cloned from GitHub.
5. Execute the following [Docker](https://docs.docker.com/engine/installation/) command from the root of the test project: ```docker run -it --rm --name protractor-runner --env-file <./utils/testenv> -v /dev/shm:/dev/shm -v $(pwd):/protractor/project <docker image>```
  - `./utils/testenv` the location of the `testenv` file on the your machine
  - `docker image` your docker image name

# Advanced options
Based on the [Webnicer project](https://hub.docker.com/r/webnicer/protractor-headless/).

## /dev/shm
Docker has hardcoded value of 64MB for `/dev/shm`. Error can be occured, because of [page crash](https://bugs.chromium.org/p/chromedriver/issues/detail?id=1097) on memory intensive pages. The easiest way to mitigate the problem is share `/dev/shm` with the host.

This needs to be done during docker build gets the [option](https://github.com/docker/docker/issues/2606) `--shm-size`.

## --privileged
Chrome uses sandboxing, therefore if you try and run Chrome within a non-privileged container you will receive the following message:

> "Failed to move to new namespace: PID namespaces supported, Network namespace supported, but failed: errno = Operation not permitted".

The `--privileged` flag gives the container almost the same privileges to the host machine resources as other processes running outside the container, which is required for the sandboxing to run smoothly.

## --net=host
This options is required only if the dockerised Protractor is run against localhost on the host.

**Imagine this scenario:**
Run an http test server on your local machine, let's say on port 8000. You type in your browser http://localhost:8000 and everything goes smoothly. Then you want to run the dockerised Protractor against the same localhost:8000. If you don't use `--net=host` the container will receive the bridged interface and its own loopback and so the localhost within the container will refer to the container itself. Using `--net=host` you allow the container to share host's network stack and properly refer to the host when Protractor is run against localhost.
