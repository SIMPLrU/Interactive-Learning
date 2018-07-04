In lieu of CURL commands, you will use HTTP commands. This allows you to visualize the HTTP request/responses for training purposes. Let’s make life a bit easier.
In lieu of CURL commands, you will use HTTP commands. This allows you to visualize the HTTP request/responses for training purposes. Let’s make life a bit easier.
`apt-get install httpie
`{{execute}}

Now, let’s test and verify Kong is running and available on the Admin API using an HTTP Get command:

`
http get http://docker:8001/
`{{execute}}
