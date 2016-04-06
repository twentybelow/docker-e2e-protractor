FROM ubuntu:trusty
MAINTAINER SequenceIQ

# Debian package configuration use the noninteractive frontend: It never interacts with the user at all, and makes the default answers be used for all questions.
# http://manpages.ubuntu.com/manpages/wily/man7/debconf.7.html
ENV DEBIAN_FRONTEND noninteractive

# Latest Googgle Chrome installation package
RUN apt-get install -y wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Update is used to resynchronize the package index files from their sources. An update should always be performed before an upgrade.
RUN apt-get update

# Latest Nodejs with npm install
# https://github.com/nodesource/distributions#installation-instructions
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN apt-get install -y nodejs build-essential

# Latest Ubuntu Firefox, Google Chrome, XVFB and JRE installs
RUN apt-get install -y xvfb firefox google-chrome-stable default-jre
# Clean clears out the local repository of retrieved package files. Run apt-get clean from time to time to free up disk space.
RUN apt-get clean

# 1. Step to fixing the error for Node.js native addon build tool (node-gyp)
# https://github.com/nodejs/node-gyp/issues/454
# https://github.com/npm/npm/issues/2952
RUN rm -fr /root/tmp

# Jasmine and protractor global install
# 2. Step to fixing the error for Node.js native addon build tool (node-gyp)
# https://github.com/nodejs/node-gyp/issues/454
RUN npm install --unsafe-perm -g protractor

# Get the latest Google Chrome driver
RUN npm update
# Get the latest WebDriver Manager
RUN webdriver-manager update

# Set the path to the global npm install directory. This is vital for Jasmine Reporters
# http://stackoverflow.com/questions/31534698/cannot-find-module-jasmine-reporters
# https://docs.npmjs.com/getting-started/fixing-npm-permissions
ENV NODE_PATH /usr/lib/node_modules

# Global reporters for protractor
RUN npm install --unsafe-perm -g jasmine-reporters jasmine-spec-reporter protractor-jasmine2-html-reporter protractor-html-screenshot-reporter

# Set the working directory
WORKDIR /protractor/
# Copy the run sript/s from local folder to the container's related folder
COPY /scripts/ /protractor/scripts/
# Set the HOME environment variable for the test project
ENV HOME=/protractor/project
# Set the owner recursively for the new folders
RUN chmod -R +x .
# Container entry point
CMD ["/protractor/scripts/run-e2e-tests.sh"]

#docker run -it --rm --name protractor-runner --env-file /utils/testenv -v /dev/shm:/dev/shm -v $(pwd):/protractor/project aszegedi/protractor
