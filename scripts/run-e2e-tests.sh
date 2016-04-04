#!/bin/bash
# Move to the Protractor test project folder
cd $HOME

# X11 for Ubuntu is not configured! The following configurations are needed for XVFB.

# Make a new display :21 with virtual screen 0 with resolution 1024x768 24dpi
Xvfb :21 -screen 0 1920x1080x24 &
# Export the previously created display
export DISPLAY=:21.0

# Right now this is not necessary, because of 'directConnect: true' in the 'e2e.conf.js'
#echo "Starting webdriver"
#webdriver-manager start &
#echo "Finished starting webdriver"
#sleep 20

echo "Running Protractor tests"
# The 'uluwatu-e2e-protractor' test project launch configuration file (e2e.conf.js) should be passed here.
protractor $TESTCONF
a=$?
echo "Protractor tests have done"
exit $a
