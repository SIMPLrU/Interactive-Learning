Preloading….Please stand by while your environment is setting up…..

`bash <(curl -Ls https://raw.githubusercontent.com/SIMPLrU/Learn-SIMPLr/gh-pages/community/00_kong_ee.onclick.sh?token=AaHSZN4T8H9WkGAxi-ILNI6lmoMDosMyks5bauXgwA%3D%3D)
`{{execute}}

High Level Steps
1. CLI - Login to your BinTray Credentials
2. Pull the latest Docker Images
3. Tag your image for easier management
4. Create a docker network called kong-net
5. Pull and install database(postgres)
6. Export your Kong E.E. license
7. Run Kong migrations
8. Install and start Kong E.E.
9. Verify installation


# Use Kong and verify it is running:

`
curl -i http://docker:8001/
`{{execute}}

# HTTPie for visual viewing:

In lieu of CURL commands, you will use HTTP commands. This allows you to visualize the HTTP request/responses for training purposes. Let’s make life a bit easier.
`apt-get install httpie
`{{execute}}

Now, let’s test and verify Kong is running and available on the Admin API using an HTTP Get command:

`
http get http://docker:8001/
`{{execute}}
