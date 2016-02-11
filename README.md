# About
Docker image for [ULUWATU functional E2E tests](https://github.com/sequenceiq/uluwatu-e2e-protractor) based on the [Docker image of Protractor with headless Chrome](https://github.com/jciolek/docker-protractor-headless)

# Docker Run
```docker run -it --rm --net=host -v /dev/shm:/dev/shm -v $(pwd):/protractor aszegedi/protractor e2e.conf.js```
