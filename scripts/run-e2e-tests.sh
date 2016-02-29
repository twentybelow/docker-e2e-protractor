#!/bin/bash
# Move to the Protractor test project folder
cd $HOME

# X11 for Ubuntu is not configured! The following configurations are needed for XVFB.

# Make a new display :21 with virtual screen 0 with resolution 1024x768 24dpi
Xvfb :21 -screen 0 1024x768x24 &
# Export the previously created display
export DISPLAY=:21.0

#echo "Starting webdriver"
#webdriver-manager start &
#echo "Finished starting webdriver"
#sleep 20

echo "Running Uluwatu E2E Tests"
protractor e2e.conf.js
a=$?
echo "Done Uluwatu test running"
exit $a