FROM ubuntu:trusty
# Change the user to root, just be sure. By default docker containers run as root.
USER root

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Update is used to resynchronize the package index files from their sources. An update should always be performed before an upgrade.
RUN apt-get update
# upgrade is used to install the newest versions of all packages currently installed. New versions of currently installed packages that cannot be upgraded without changing the install status of another package will be left at their current version.
# https://github.com/tianon/docker-brew-debian/issues/4
RUN apt-get -y upgrade

# Googgle Chrome installation package
RUN apt-get install -y wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Node.js 5 with npm install
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo bash -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential

# Firefox, Google Chrome, XVFB and JRE installs
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
RUN npm install --unsafe-perm -g jasmine-reporters
RUN npm install --unsafe-perm -g jasmine-spec-reporter
RUN npm install --unsafe-perm -g protractor-jasmine2-html-reporter
RUN npm install --unsafe-perm -g protractor-html-screenshot-reporter

# Set the working directory
WORKDIR /protractor/
# Copy the run sript/s from local folder to the container's related folder
COPY /scripts/ /protractor/scripts/
# Set the owner recursively for the new folders
RUN chmod -R +x .
# Set the HOME environment variable for the test project
ENV HOME=/protractor/project
# Container entry point
CMD ["/protractor/scripts/run-e2e-tests.sh"]

#docker run -it --rm --name protractor-runner --env-file /utils/testenv -v /dev/shm:/dev/shm -v $(pwd):/protractor/project aszegedi/protractor
