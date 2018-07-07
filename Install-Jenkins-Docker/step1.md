Install Latest Jenkins Container exposing the dashboard port 8080 with this commmand.

`docker run -d -u root --name jenkins \
    -p 8080:8080 -p 50000:50000 \
    -v /root/jenkins:/var/jenkins_home \
    jenkins:latest`{{execute}}

All plugins and configurations get persisted to the host (ssh root@host01) at _/root/jenkins. Port 8080 opens the web dashboard, 50000 is used to communicate with other Jenkins agents. Finally, the image has an alpine base to reduce the size footprint.
