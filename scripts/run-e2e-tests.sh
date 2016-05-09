#!/bin/bash
# Move to the Protractor test project folder
cd $HOME

# Install the necessary npm packages
npm install

# X11 for Ubuntu is not configured! The following configurations are needed for XVFB.

# Make a new display :21 with virtual screen 0 with resolution 1024x768 24dpi
Xvfb :21 -screen 0 1920x1080x24 &
# Export the previously created display
export DISPLAY=:21.0

# This is not necessary if 'directConnect: true' in the 'conf.js'
echo "Starting webdriver"
webdriver-manager start &
echo "Finished starting webdriver"
sleep 20

echo "Running Protractor tests"
# The test project launch configuration file (conf.js) should be passed here.
protractor $TESTCONF
a=$?
echo "Protractor tests have done"

# Remove temporary folders here if it is needed
#rm -rf .cache .dbus .gconf .mozilla node_modules
# Set the owner recursively for the result folders
chmod -Rf 777 test-results

exit $a
