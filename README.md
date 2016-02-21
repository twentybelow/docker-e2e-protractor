# About
Docker image for [ULUWATU functional E2E tests](https://github.com/sequenceiq/uluwatu-e2e-protractor) test project.

The [Dockerfile](Dockerfile) was design based on the following projects:
- [Protractor and headless Chrome on Docker](http://float-middle.com/protractor-and-headless-chrome-on-docker-with-video-tutorial/) or [Docker image of Protractor with headless Chrome](https://github.com/jciolek/docker-protractor-headless)
- [docker-protractor](https://github.com/School-Improvement-Network/docker-protractor)

# Docker Run
1. Provide valid and appropriate values for base test parameters in the [run script](scripts/run-e2e-tests.sh):
  - BASE_URL=https://pre-prod-accounts.sequenceiq.com/
  - USERNAME
  - PASSWORD
  - IAMROLE
  - SSHKEY
2. Open the local folder where the [ULUWATU functional E2E tests](https://github.com/sequenceiq/uluwatu-e2e-protractor) project was cloned from GitHub.
3. Execute the following [Docker](https://docs.docker.com/engine/installation/) command: ```docker run -it --name protractor-runner -v /dev/shm:/dev/shm -v $(pwd):/protractor/project aszegedi/protractor```
