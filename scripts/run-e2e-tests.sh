#!/bin/bash
# Move to the Protractor test project folder
cd $HOME

# Remove previous Allure results
rm -rf allure-results

#Install the necessary npm packages
npm install

# X11 for Ubuntu is not configured! The following configurations are needed for XVFB.
# Make a new display :21 with virtual screen 0 with resolution 1024x768 24dpi
Xvfb :10 -screen 0 1920x1080x24 2>&1 >/dev/null &

# Right now this is not necessary, because of 'directConnect: true' in the 'e2e.conf.js'
#echo "Starting webdriver"
#webdriver-manager start &
#echo "Finished starting webdriver"
#sleep 20

echo "Running Protractor tests"
# The 'uluwatu-e2e-protractor' test project launch configuration file (e2e.conf.js) should be passed here.
DISPLAY=:10 protractor $TESTCONF
export RESULT=$?

echo "Protractor tests have done"
killall Xvfb
# Remove temporary folders
rm -rf .cache .dbus .gconf .mozilla node_modules Desktop
# Set the file access permissions (read, write and access) recursively for the result folders
chmod -Rf 777 allure-results test-results

exit $RESULT