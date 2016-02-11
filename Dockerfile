FROM ubuntu:trusty

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

MAINTAINER Annamaria Szegedi <aszegedi@hortonworks.com>

RUN apt-get -y update
RUN apt-get install -y -q software-properties-common wget
RUN add-apt-repository -y ppa:mozillateam/firefox-next
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update -y
RUN apt-get install -y -q \
  firefox \
  google-chrome-stable \
  openjdk-7-jre-headless \
  nodejs \
  xvfb

RUN npm install -g protractor
RUN webdriver-manager update

RUN mkdir -p /protractor

ADD protractor.sh /protractor.sh

WORKDIR /protractor
ENTRYPOINT ["sh", "/protractor.sh"]

#!/bin/bash
#docker run -it --rm --net=host -v /dev/shm:/dev/shm -v $(pwd):/protractor aszegedi/protractor $@
#protractor.sh [protractor options]
