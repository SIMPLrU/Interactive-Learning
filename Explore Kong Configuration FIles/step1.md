**Location:/usr/local/kong** <br>
To view the **Nginx.conf** file, navigate to the Kong folder. <br>
**Note** If you are using a container, make sure you have SSH or shell access to Kong


Let's access the Kong container shell.
Use this command to gain access to the container shell. Note: `Kong` is the name of our container we have preset during the install. 

`
docker exec -ti kong /bin/sh
`{{execute}}


Now lets view the `nginx.conf` file by using this command.

`
cat usr/local/kong/nginx.conf
`{{execute}}


> Results - The results should look like this. 
```sh
worker_processes auto;
daemon off;
pid pids/nginx.pid;
error_log logs/error.log notice;
worker_rlimit_nofile 1048576;
events {
worker_connections 16384;
multi_accept on;
}
http {
include 'nginx-kong.conf';
}
```
> Notice that last call is to the **nginx-kong.conf file** . Let's look at that file. <br>
<br>

