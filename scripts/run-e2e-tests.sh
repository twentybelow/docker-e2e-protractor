#!/bin/bash
# Set the test parameters for the used environment variables
export BASE_URL=https://pre-prod-accounts.sequenceiq.com/
export USERNAME=[user@name]
export PASSWORD=[password]
export IAMROLE=arn:aws:iam::1234567890:role/userrole
export SSHKEY=AAAAB3NzaC1+soon
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