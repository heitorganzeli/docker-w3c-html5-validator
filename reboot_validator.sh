#!/bin/bash

/bin/systemctl stop docker-w3c_validator.service
/usr/bin/dockerdocker rm w3c_validator
/usr/bin/dockerdocker docker run -d -p 45000:80 --name w3c_validator nicbr/w3c-html5-validator
