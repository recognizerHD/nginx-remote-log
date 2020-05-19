# NGINX Docker Image with Remote Error Logging

This docker image is based on the alpine docker image.

The notable differences from the base image are:
* Options to specify a remote logging service for error and access logs.
* A customized look fo the access log
* Various optimizations for caching of static files
* Requires another cgi service to be running to pass requests to over port 9000
* Runs in the root /var/www/public

## Step 1 - Setup

This was developed to run along side another docker image: \
[recognizerhd/php-fpm](https://hub.docker.com/repository/docker/recognizerhd/php-fpm) \
By default, it is expecting a service called app with an open port 9000 to be running.

## Step 2 - How to use this image
```
$ docker run --name some-nginx --network private --mount src=sourcefiles,dst=/var/www/ -e LOG_HOST=logs#.papertrailapp.com -e LOG_PORT=##### -e PASS_HOST=app_host_name -e PASS_PORT=9001 recognizerhd/nginx-remote-log:latest
```

Options include: \
`LOG_HOST` - the remote server to connect to \
`LOG_PORT` - the port of the remote server \
These environment variables were designed to connect to papertrail. It may or may not work with other services but these have not been verified.

`PASS_HOST` - the fastcgi_pass service to connect to \
`PASS_PORT` - the port of the service to connect with \
