#!/bin/bash
/usr/bin/git pull
/bin/systemctl stop docker-w3c_validator.service
/usr/bin/docker rm w3c_validator
/usr/bin/docker build -t nicbr/w3c-html5-validator .
/usr/bin/docker run -d -p 45000:80 --name w3c_validator nicbr/w3c-html5-validator
/bin/systemctl start docker-w3c_validator.service
