# Load Jenkins Dashboard
> To ensure Jenkins is securely set up by the administrator, a password has been written to the log and this file on the server: `/var/jenkins_home/secrets/initialAdminPassword`

> The username is `admin`{{copy}} with the password the default `<adminpassword>`

> ## Discover adminpassword 
On this environment, the password can be found via 
`docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
`{{execute}}

>It may take a couple of seconds for Jenkins to finish starting and be available. In the next steps, you'll use the dashboard to configure the plugins and start building Docker Images.


# Launch Jenkins Dashboard
> After a few moments you will be able to visit the UI on port 8080 with the URL https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com
> Note: use the `<adminpassword>` in the previous step.

Enable Autorefresh
