# Run the migrations with an ephemeral Kong container:

`docker run --rm \
    --network=kong-net \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    kong:latest kong migrations up
`{{execute}}

In the above example, both Cassandra and PostgreSQL are configured, but you should update the KONG_DATABASE environment variable with either cassandra or postgres.

Note: Migrations should never be run concurrently; only one Kong node should be performing migrations at a time.
