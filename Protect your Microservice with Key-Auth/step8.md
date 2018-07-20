Verify that your Consumer credentials are valid

You can now issue the following request to verify that the credentials of your `Jason` Consumer is valid:

`curl -i -X GET \
  --url http://docker:8000 \
  --header "Host: example.com" \
  --header "apikey: jasonkey"
`{{execute}}

or

`http get docker:8000 host:example.com apikey:jasonkey`{{execute}}
