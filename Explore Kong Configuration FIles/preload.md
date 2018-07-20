YOUR SYSTEM IS LOADING....

The Preconfiguration does the following
1. Create a Docker Network called kong-net
2. Installs and starts the database (postgres 9.6)
3. Prepares your database (Kong migration)
4. Installs and starts Kong with environment variables and configurations


This may take up to 1 minute

`docker images`{{execute}} 
`docker ps -a`{{execute}} 
`docker ps`{{execute}}

`curl -i http://docker:8001`{{execute}} 
`http get docker:8001`{{execute}}