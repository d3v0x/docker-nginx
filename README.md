# nginx Docker Image

![Build](https://jenkins.nespithal.com/buildStatus/icon?job=docker-nginx)

## Set up
You have to link in your custom nginx.conf from your host system.

For example:

Create a new nginx.conf within your home directory of the host `/home/[myuser]/nginx.conf` and start the docker container. Be sure you add `daemon off;` on top of your `nginx.conf`.

`docker run -d -p 443:443 -p 80:80 -v /home/[myuser]/nginx.conf:/etc/nginx/nginx.conf --name nginx d3v0x/nginx`

## Link other containers into the nginx container

Docker creates a new entry in `/etc/hosts` for each container so it can be used within your `nginx.conf`

For example use my [d3v0x/jenkins](https://github.com/d3v0x/docker-jenkins) image and create a new container called `jenkins`. After this run:

`docker run -d --link jenkins:jenkins -p 443:443 -p 80:80 -v /home/[myuser]/nginx.conf:/etc/nginx/nginx.conf --name nginx d3v0x/nginx`

Your nginx.conf proxy pass would be http://[yourcontainername]:8080 for this jenkins example:

```
location / {
	proxy_pass http://jenkins:8080;
	...
}
```

## Add certificates to use https://

If you want to use SSL encryption (you should use), you can use my [d3v0x/letsencrypt](https://github.com/d3v0x/docker-letsencrypt) image to create some certificates. You can mount them as another data volume from your host container. Be sure you add the correct path to your `nginx.conf`

Example:

On your host the certificates are located in 

```
ssl_certificate /home/[username]/certs/jenkins/live/jenkins.mydomain.ltd/fullchain.pem;
ssl_certificate_key /home/[username]/certs/jenkins/live/jenkins.mydomain.ltd/privkey.pem;

```

You have to mount the `/home/[username]/certs` directory as another data volume to `/certs` within your nginx container. To do this, execute the nginx container run command with another `-v /home/[username]/certs/:/certs`. So you can access these certificates within your `nginx.conf`:

```
...
server {
	listen 443;
	server_name jenkins.mydomain.ltd;
				                
	ssl on;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
	ssl_certificate /certs/jenkins/live/jenkins.mydomain.ltd/fullchain.pem;
	ssl_certificate_key /certs/jenkins/live/jenkins.mydomain.ltd/privkey.pem;
	...
```
