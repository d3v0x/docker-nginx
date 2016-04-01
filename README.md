# nginx Docker Image

## Set up
You have to link in your custom nginx.conf from your host system.

For example:

Create a new nginx.conf within your home directory of the host `/home/[myuser]/nginx.conf` and start the docker container. Be sure you add `daemon off;` on top of your `nginx.conf`.

`docker run -d -p 443:443 -p 80:80 -v /home/[myuser]/nginx.conf:/etc/nginx/nginx.conf --name nginx d3v0x/nginx`

## Link other containers into the nginx container

Docker creates a new entry in `/etc/hosts` for each container so it can be used within your `nginx.conf`

For example use my d3v0x/jenkins image and create a new container called `jenkins`. After this run:

`docker run -d --link jenkins:jenkins -p 443:443 -p 80:80 -v /home/[myuser]/nginx.conf:/etc/nginx/nginx.conf --name nginx d3v0x/nginx`

Your nginx.conf proxy pass would be http://[yourcontainername]:8080 for this jenkins example:

```
location / {
	proxy_pass http://jenkins:8080;
	...
}
```
