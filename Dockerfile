FROM ubuntu:trusty
# Update is used to resynchronize the package index files from their sources. An update should always be performed before an upgrade.
RUN apt-get update
# upgrade is used to install the newest versions of all packages currently installed. New versions of currently installed packages that cannot be upgraded without changing the install status of another package will be left at their current version.
RUN apt-get -y upgrade

# Googgle Chrome installation package
RUN apt-get install -y wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Node.js 5 with npm install
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# Firefox, Google Chrome, XVFB and JRE installs
RUN apt-get install -y xvfb firefox google-chrome-stable default-jre
# Clean clears out the local repository of retrieved package files. Run apt-get clean from time to time to free up disk space.
RUN apt-get clean

# Jasmine and protractor global install
RUN npm install -g protractor

# Get the latest WebDriver Manager with Google Chrome driver
RUN npm update
RUN webdriver-manager update

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