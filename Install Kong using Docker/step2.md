This lab uses PostgreSQL container. Let's go ahead and install it.  

`
docker run -d --name kong-database \
              --network=kong-net \
              -p 5432:5432 \
              -e "POSTGRES_USER=kong" \
              -e "POSTGRES_DB=kong" \
              postgres:9.6
`{{execute}}

Verify that database is installed with this command: `docker ps `{{execute}}
