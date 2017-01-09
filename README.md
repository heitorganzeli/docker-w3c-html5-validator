# docker-w3c-html5-validator

Docker image for W3C HTML 5 validator to be used with top-sites/brsites site 
analysis


## Building

to build this image run

    $ docker build -t nicbr/w3c-html5-validator .

This will take some time (lots to download), performing the following tasks:

* Install Ubuntu base (16.04), Apache HTTP server, OpenJDK 8, supervisord and a
  few others.
* Download W3C validator and Validator.nu vnu.jar portable HTML5 validator jar
  (version 17.0.1).
* Install and configure W3C validator (including Validator.nu setup).
* Start Apache and Validator.nu under supervisord.


## Running

To start the image run:

    $ docker run -d -p 45000:80 --name w3c_validator nicbr/w3c-html5-validator

this will start the image in a new container and expose the w3c-checker to be 
used on port 45000 URL is `http://localhost:45000/w3c-validator/`

To view IP address of the container:

    $ docker ps
    $ docker inspect w3c_validator


## Deploy

To make sure the image starts with system startup systemd can be used.

Create the following script at `/etc/systemd/system/docker-w3c_validator.service`

```systemd
[Unit]
Description=W3C validator container
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a w3c_validator
ExecStop=/usr/bin/docker stop -t 2 w3c_validator

[Install]
WantedBy=default.target
```

run: 

    $ systemctl enable docker-w3c_validator.service
    
### Health Check

The validator checker server tends to fail and stop executing checks under high
load.

To prevent those performance issues to affect page validation results, the 
`health_checker.py` script was created. It try to access the local validator 
instance and if any exception is raised, it uses the `reboot_validator.sh` to
restart the service.

Because a simple `docker stop` `docker start` doesn't always make the service
work again, the restart script deletes the old docker image and creates a new
one withe the same parameters.


## Maintenance

The Dockerfile should be updated whenever there is a new release on 
[https://github.com/validator/validator/releases](https://github.com/validator/validator/releases)

## Credits

This image is builded on top of: 

* [https://github.com/setelis/docker-w3c-html5-validator](https://github.com/setelis/docker-w3c-html5-validator)
