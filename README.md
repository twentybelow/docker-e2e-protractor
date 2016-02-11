# About
Docker image for [ULUWATU functional E2E tests](https://github.com/sequenceiq/uluwatu-e2e-protractor) based on the 
[Protractor and headless Chrome on Docker](http://float-middle
.com/protractor-and-headless-chrome-on-docker-with-video-tutorial/) or [Docker image of Protractor with headless Chrome](https://github
.com/jciolek/docker-protractor-headless) project.

# Docker Run
```docker run -it --rm --net=host -v /dev/shm:/dev/shm -v $(pwd):/protractor aszegedi/protractor e2e.conf.js```
