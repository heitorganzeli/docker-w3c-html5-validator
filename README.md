# docker-w3c-html5-validator

Docker image for W3C HTML 5 validator to be used with top-sites/brsites site analysis


## Building

to build this image run

    $ docker build -t nicbr/w3c-html5-validator .

This will take some time (lots to download), performing the following tasks:

* Install Ubuntu base (15.10), Apache HTTP server, OpenJDK 8, supervisord and a few others.
* Download W3C validator and Validator.nu vnu.jar portable HTML5 validator jar (version 15.6.29).
* Install and configure W3C validator (including Validator.nu setup).
* Start Apache and Validator.nu under supervisord.


## Running

To start the image run:

    $ docker run -d -p 45000:80 --name w3c_validator nicbr/w3c-html5-validator

this will start the image in a new container and expose the w3c-checker to be used on port 45000
URL is `http://localhost:45000/w3c-validator/`

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


## Credits

This image is builded on top of: 

* [https://github.com/setelis/docker-w3c-html5-validator](https://github.com/setelis/docker-w3c-html5-validator)
