Let's verify that your service was created: Run this command

`curl -i http://docker:8001/services`{{execute}} 

or 

`http docker:8001/services`{{execute}}

You should receive a response similar to this:

`HTTP/1.1 200 OK
Access-Control-Allow-Origin: *
Connection: keep-alive
Content-Type: application/json; charset=utf-8
Date: Sat, 23 Jun 2018 10:17:12 GMT
Server: kong/0.13.1
Transfer-Encoding: chunked
{
    "data": [
        {
            "connect_timeout": 60000,
            "created_at": 1529745986,
            "host": "mockbin.org/requests",
            "id": "0b79f153-7da6-4275-a9c7-5e9bd550369e",
            "name": "example-service",
            "path": null,
            "port": 80,
            "protocol": "http",
            "read_timeout": 60000,
            "retries": 5,
            "updated_at": 1529745986,
            "write_timeout": 60000
        },
`
