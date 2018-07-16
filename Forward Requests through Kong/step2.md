Issue the following cURL request to add your first Service (pointing to the Mockbin API) to Kong:

`
curl -i -X POST \
  --url http://docker:8001/services/ \
  --data 'name=example-service' \
  --data 'url=http://mockbin.org/requests'
`{{execute}}

OR 

`
http post docker:8001/services \
name=example-service \
url=http://mockbin.org/requests
`{{execute}}

<br>
You should receive a response similar to
`HTTP/1.1 201 Created
Content-Type: application/json
Connection: keep-alive
{
   "host":"mockbin.org/requests",
   "created_at":1519130509,
   "connect_timeout":60000,
   "id":"92956672-f5ea-4e9a-b096-667bf55bc40c",
   "protocol":"http",
   "name":"example-service",
   "read_timeout":60000,
   "port":80,
   "path":null,
   "updated_at":1519130509,
   "retries":5,
   "write_timeout":60000
}`
