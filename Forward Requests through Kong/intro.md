In this section, you'll be adding an API to Kong. In order to do this, you'll first need to add a Service; that is the name Kong uses to refer to the upstream APIs and microservices it manages.

For the purpose of this guide, we'll create a Service pointing to the Mockbin API. Mockbin is an "echo" type public website which returns the requests it gets back to the requester, as reponses. This makes it helpful for learning how Kong proxies your API requests.

Before you can start making requests against the Service, you will need to add a Route to it. Routes specify how (and if) requests are sent to their Services after they reach Kong. A single Service can have many Routes.

After configuring the Service and the Route, you'll be able to make requests through Kong using them.
Kong exposes a RESTful Admin API on port :8001. Kong is configuration, including adding Services and Routes, is made via requests on that API.
