FROM ubuntu:trusty

RUN apt-get install -y wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

RUN apt-get install -y firefox google-chrome-stable xvfb default-jre

RUN apt-get clean

RUN npm install -g jasmine-node karma-firefox-launcher karma-chrome-launcher protractor

RUN npm update
RUN webdriver-manager update

WORKDIR /protractor/

COPY /scripts/ /protractor/scripts/

RUN chmod -R +x .

ENV HOME=/protractor/project

CMD ["/protractor/scripts/run-e2e-tests.sh"]

#docker run -it --name protractor-runner -v /dev/shm:/dev/shm -v $(pwd):/protractor/project aszegedi/protractor
#docker run -it --name protractor-runner -v /dev/shm:/dev/shm -v $(pwd):/protractor/project -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY aszegedi/protractor