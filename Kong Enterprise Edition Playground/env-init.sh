docker login -u viet-phan_simplru@kong -p bfb3fa490d912f9132b76e941fd6af8d1ad66d28 kong-docker-kong-enterprise-edition-docker.bintray.io
sleep 2s
docker pull kong-docker-kong-enterprise-edition-docker.bintray.io/kong-enterprise-edition:latest
sleep 2s
docker tag kong-docker-kong-enterprise-edition-docker.bintray.io/kong-enterprise-edition:latest kong-ee
sleep 1s
docker network create kong-net
sleep 1s
docker run -d --name kong-ee-database -p 5432:5432 -e "POSTGRES_USER=kong" -e "POSTGRES_DB=kong" postgres:9.6
sleep 1s
export KONG_LICENSE_DATA='{"license":{"signature":"8840ad1af4cbd801692971460beea8e6d018a4fb474a47e980196bd1c9c8da63c0a2b22d3e040b208856e4a5cb62608c2605615bacb4b8d05d9d484b127247bd","payload":{"customer":"Kong Inc","license_creation_date":"2017-11-29","product_subscription":"Kong Enterprise Edition","admin_seats":"5","support_plan":"None","license_expiration_date":"2018-11-29","license_key":"0014100000VLx1zAAD_a1V41000004y13JEAQ"},"version":1}}'
sleep 3s
docker run --rm --link kong-ee-database:kong-ee-database -e "KONG_DATABASE=postgres" -e "KONG_PG_HOST=kong-ee-database" -e "KONG_CASSANDRA_CONTACT_POINTS=kong-ee-database" -e "KONG_LICENSE_DATA=$KONG_LICENSE_DATA" kong-ee kong migrations up
sleep 3s
docker run -d --name kong-ee --link kong-ee-database:kong-ee-database -e "KONG_DATABASE=postgres" -e "KONG_PG_HOST=kong-ee-database" -e "KONG_CASSANDRA_CONTACT_POINTS=kong-ee-database" -e "KONG_PROXY_ACCESS_LOG=/dev/stdout" -e "KONG_ADMIN_ACCESS_LOG=/dev/stdout" -e "KONG_PROXY_ERROR_LOG=/dev/stderr" -e "KONG_ADMIN_ERROR_LOG=/dev/stderr" -e "KONG_VITALS=on" -e "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl" -e "KONG_PORTAL=on" -e "KONG_PORTAL_GUI_URI=localhost:8003" -e "KONG_LICENSE_DATA=$KONG_LICENSE_DATA" -p 8000:8000 -p 8443:8443 -p 8001:8001 -p 8444:8444 -p 8002:8002 -p 8445:8445 -p 8003:8003 -p 8004:8004 kong-ee
