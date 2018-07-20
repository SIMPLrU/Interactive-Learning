Configure the key-auth plugin for the service you previously configured in Kong
`
curl -i -X POST \
  --url http://docker:8001/services/example-service/plugins/ \
  --data 'name=key-auth'
`{{execute}}

or

`http post docker:8001/services/example-service/plugins/ name=key-auth`{{execute}}


**Note:** This plugin also accepts a `config.key_names` parameter, which
    defaults to `['apikey']`. It is a list of headers and parameters names (both
    are supported) that are supposed to contain the apikey during a request.
