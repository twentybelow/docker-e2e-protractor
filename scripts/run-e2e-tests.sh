#!/bin/bash

export BASE_URL=https://pre-prod-accounts.sequenceiq.com/
export USERNAME=[user@name]
export PASSWORD=[password]
export IAMROLE=arn:aws:iam::1234567890:role/userrole
export SSHKEY=AAAAB3NzaC1+soon

cd $HOME

Xvfb :21 -screen 0 1024x768x24 &
export DISPLAY=:21.0

#echo "Starting webdriver"
#webdriver-manager start &
#echo "Finished starting webdriver"
#sleep 20

echo "Running Test"
protractor e2e.conf.js
a=$?
echo "Done running test"
exit $a