#!/bin/bash
sudo sleep 10 #makes job to wait for 10 seconds so that server can be ready for connection

nstatus=200 

status=$(curl -o /dev/null/ -s -w "%{http_code}" 192.168.99.100:32000) #connects to server and gets status code


if [ "$status" == "$nstatus" ] #checks whether status code is 200 meaning request was process else there was a problem
then
echo "Server up and running"
else
echo "Error detected"
echo "Status code $status"
echo "Sending mail to developer"
sudo python3 /var/lib/jenkins/workspace/repoGetter/mail.py #sends a mail to the developer if status code not equal to 200
echo "Mail Successful"
exit 1
fi