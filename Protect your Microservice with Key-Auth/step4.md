Verify that the plugin is properly configured

Issue the following cURL request to verify that the [key-auth][key-auth] plugin was properly configured on the Service:

`
curl -i -X GET \
  --url http://docker:8000/ \
  --header 'Host: example.com'
`{{execute}}

or 


`http get docker:8000 host:example.com `{{execute}}


Since you did not specify the required `apikey` header or parameter, the response should be `401 Unauthorized`:

  ```http
    HTTP/1.1 401 Unauthorized
    ...

    {
      "message": "No API key found in request"
    }
    ```
