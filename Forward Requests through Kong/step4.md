Let's create a route for the service. 

`
curl -i -X POST \
--url http://docker:8001/services/example-service/routes \
--data 'hosts[]=example.com'
`{{execute}}


The answer should be similar to:

`HTTP/1.1 201 Created
Content-Type: application/json
Connection: keep-alive
{
   "created_at":1519131139,
   "strip_path":true,
   "hosts":[
      "example.com"
   ],
   "preserve_host":false,
   "regex_priority":0,
   "updated_at":1519131139,
   "paths":null,
   "service":{
      "id":"79d7ee6e-9fc7-4b95-aa3b-61d2e17e7516"
   },
   "methods":null,
   "protocols":[
      "http",
      "https"
   ],
   "id":"f9ce2ed7-c06e-4e16-bd5d-3a82daef3f9d"
}`

**Kong is now aware of your Service and ready to proxy requests.**

Let's verify the route has been created

`curl -i http://docker:8001/routes`{{execute}} 


`http get docker:8001/routes`{{execute}}

