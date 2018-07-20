Lets create a user named `Jason` by issuing the following request:

`curl -i -X POST \
--url http://docker:8001/consumers/ \
--data 'username=Jason'
`{{execute}}

OR
 

`http post docker:8001/consumers/ username=Jason`{{execute}}



You should see a response similar to the one below:

`HTTP/1.1 201 Created
Content-Type: application/json
Connection: keep-alive
{
 "username": "Jason",
 "created_at": 1428555626000,
 "id": "bbdf1c48-19dc-4ab7-cae0-ff4f59d87dc9"
    }`


## Congratulations! You've just added your first consumer to Kong.

**Note:** Kong also accepts a `custom_id` parameter when creating consumersto associate a consumer with your existing user database.