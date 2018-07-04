# Use Kong and verify it is running:

`
curl -i http://docker:8001/
`{{execute}}


# ACCESS KONG BASH

Access the Kong container bash

Obtain Kong Container ID
`docker ps`{{execute}}


Run Docker bash command to access bash. 
`docker exec -ti kong /bin/sh`{{execute}}


# RUN SOME KONG COMMANDS
Run a Kong Version 
`kong version`{{execute}}

Run a Kong Check
`kong check`{{execute}}

Run a Kong Health
`kong health`{{execute}}