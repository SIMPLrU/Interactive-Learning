Provision key credentials for your Consumer

Now, you can create a key for your recently created consumer `Jason` by
issuing the following request:

`curl -i -X POST \
  --url http://docker:8001/consumers/Jason/key-auth/ \
  --data 'key=jasonkey'
`{{execute}}

or 

`http post docker:8001/consumers/Jason/key-auth/ key=jasonkey`{{execute}}