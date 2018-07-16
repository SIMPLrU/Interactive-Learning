Issue the following cURL request to verify that Kong is properly forwarding requests to your Service. Note that by default Kong handles proxy requests on port :8000:

`
curl -i -X GET \
  --url http://docker:8000/ \
  --header 'Host: example.com'
`{{execute}}

or 

`http get docker:8000/ host:example.com`{{execute}}

#Congratulations
A successful response means Kong is now forwarding requests made to http://docker:8000 to the url we configured in step #1, and is forwarding the response back to us. Kong knows to do this through the header defined in the above cURL request:

Host: < given host >
