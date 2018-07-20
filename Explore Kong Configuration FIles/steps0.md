## **Overview** 
In the previous sections, you 
[Installed Kong Using Docker Compose](https://simplru.gelato.io/guides/install-kong-using-docker-compose)
and [Provisioned, Protected and Rate Limited your API](https://simplru.gelato.io/guides/protect-and-rate-limit-your-api). Lets take a deeper look at various configuration files. 

In this section, you will explore NGINX-KONG configurations files.  The two main files are:
1. NGINX.conf
2. NGINX-Kong.conf

## **Nginx.Conf**
**Location:/usr/local/kong** <br>
To view the **Nginx.conf** file, navigate to the Kong folder. <br>
**Note** If you are using a container, make sure you have SSH or shell access to Kong

```sh
$ cat </<path_to_location>/kong/nginx.conf
```
> Results
```sh
worker_processes auto;
daemon off;
pid pids/nginx.pid;
error_log logs/error.log notice;
worker_rlimit_nofile 1048576;
events {
worker_connections 16384;
multi_accept on;
}
http {
include 'nginx-kong.conf';
}
```
> Notice that last call is to the **nginx-kong.conf file** . Let's look at that file. <br>
<br>



## **Nginx-Kong.Conf** 
**Location:/usr/local/kong** <br>
To view the **Nginx-Kong.conf** file, navigate to the Kong folder. <br>
**Note** If you are using a container, make sure you have SSH or shell access to Kong
```sh
$ cat </<path_to_location>/kong/nginx-kong.conf
```
> Results
```sh
error_log logs/error.log notice;
error_log syslog:server=kong-hf.mashape.com:61828 error;
client_max_body_size 0;
proxy_ssl_server_name on;
underscores_in_headers on;
real_ip_header X-Forwarded-For;
set_real_ip_from 0.0.0.0/0;
real_ip_recursive on;
lua_package_path '?/init.lua;./kong/?.lua;;';
lua_package_cpath ';;';
lua_code_cache on;
lua_socket_pool_size 30;
lua_max_running_timers 4096;
lua_max_pending_timers 16384;
lua_shared_dict kong 4m;
lua_shared_dict cache 128m;
lua_shared_dict cache_locks 100k;
lua_shared_dict process_events 1m;
lua_shared_dict cassandra 5m;
lua_socket_log_errors off;
init_by_lua_block {
  require 'resty.core'
  kong = require 'kong'
	   kong.init()
init_worker_by_lua_block {
  kong.init_worker()
	}
proxy_next_upstream_tries 999;
upstream kong_upstream {
  server 0.0.0.1;
	"/usr/local/kong/nginx-kong.conf" 159L, 3677C
	upstream kong_upstream {
	server 0.0.0.1;
	balancer_by_lua_block {
	  kong.balancer()
	   }
	   keepalive 60;
	}
map $http_upgrade $upstream_connection {
  default keep-alive;
  websocket upgrade;
	}
map $http_upgrade $upstream_upgrade {
  default '';
  websocket websocket;
	}
server {
  server_name kong;
  listen 0.0.0.0:8000;
  error_page 404 408 411 412 413 414 417 /kong_error_handler;
	error_page 500 502 503 504 /kong_error_handler;
access_log logs/access.log;
listen 0.0.0.0:8443 ssl;
ssl_certificate /usr/local/kong/ssl/kong-default.crt;
ssl_certificate_key /usr/local/kong/ssl/kong-default.key;
ssl_protocols TLSv1.1 TLSv1.2;
ssl_certificate_by_lua_block {
kong.ssl_certificate()
  }
location / {
	set $upstream_host nil;
  set $upstream_scheme nil;
rewrite_by_lua_block {
  kong.rewrite()
  }
```


## **Summary**
* Kong allows you to replace your existing NGINX implementation with Kong and still retain 100% of the old functionality.
* It leverages the OpenResty team directive to access everything in the event life cycle
* Additional functionality can be built through plugins, either through Kong or the community. 


## What Next
Lets look at the Kong conf file where you can customize and optimize your Kong environment. This is one of the most essential steps you will do. 

#### [Explore KONG Configuration Files](https://simplru.gelato.io/guides/explore-kong-configuration-file




## **Overview**
Customizing the Kong configuration is essential to optimizing your environment.
In the previous lab, you looked at the [NGINX-KONG Configuration Files](https://simplru.gelato.io/guides/explore-nginx-kong-configuration-files). 

In this lab, lets explore the Kong startup configuration file(s).  
The default startup configuration file is **Kong.conf.default**


We recommend that you make a copy to this file.  

* **Filemame:** - kong.conf.default <br>
* **Location:** /etc/kong


**Note:** In this lab, you will only explore this file. In later labs, you'll modify and optimize these configuration.

## Kong Configure File

**Location:/etc/kong** <br>
To view the **Kong.conf.default** file, navigate to the Kong folder. <br>
**Note** If you are using a container, make sure you have SSH or shell access to Kong

Run the command below to view the file. 
```sh
$ cat </<path_to_location>/kong/kong.conf.default
```
> The results should look like this. 

```json
# ---------------------------------------
# Kong configuration file
# ---------------------------------------
#
# The commented-out settings shown in this file represent the default values.
#
# This file is read when `kong start` or `kong compile` are used. Kong
# generates the Nginx configuration with the settings specified in this file.
#
# All environment variables prefixed with `KONG_` and capitalized will override
# the settings specified in this file.
# Example:
#   `log_level` setting -> `KONG_LOG_LEVEL` env variable
#
# Boolean values can be specified as `on`/`off` or `true`/`false`.
# Lists must be specified as comma-separated strings.
#
# All comments in this file can be removed safely, including the
# commented-out properties.
# You can verify the integrity of your settings with `kong check <conf>`.
```
> This gives you information on the Kong configuration file. 

--

### General Section 

This section is for general configurations. To make changes, uncomment the parameters and add the configuration parameter. For example, you can modify the log_level to "error" to increase the logging details. 


```java
#------------------------------------------------------------------------------
# GENERAL
#------------------------------------------------------------------------------

#prefix = /usr/local/kong/       # Working directory. Equivalent to Nginx's
                                 # prefix path, containing temporary files
                                 # and logs.
                                 # Each Kong process must have a separate
                                 # working directory.

#log_level = notice              # Log level of the Nginx server. Logs are
                                 # found at <prefix>/logs/error.log
# Note: See http://nginx.org/en/docs/ngx_core_module.html#error_log for a list
# of accepted values.

#custom_plugins =                # Comma-separated list of additional plugins
                                 # this node should load.
                                 # Use this property to load custom plugins
                                 # that are not bundled with Kong.
                                 # Plugins will be loaded from the
                                 # `kong.plugins.{name}.*` namespace.

#anonymous_reports = on          # Send anonymous usage data such as error
                                 # stack traces to help improve Kong.
```

---

### NGINX Section
This section is for the NGINX configurations. For example, you can modify the proxy or admin listening port(s) (8000,8001).  

```java
#------------------------------------------------------------------------------
# NGINX
#------------------------------------------------------------------------------

# proxy_listen = 0.0.0.0:8000     # Address and port on which Kong will accept
                                 # HTTP requests.
                                 # This is the public-facing entrypoint of
                                 # Kong, to which your consumers will make
                                 # requests to.
# Note: See http://nginx.org/en/docs/http/ngx_http_core_module.html#listen for
# a description of the accepted formats for this and other *_listen values.

#proxy_listen_ssl = 0.0.0.0:8443 # Address and port on which Kong will accept
                                 # HTTPS requests if `ssl` is enabled.

#admin_listen = 0.0.0.0:8001     # Address and port on which Kong will expose
                                 # an entrypoint to the Admin API.
                                 # This API lets you configure and manage Kong,
                                 # and should be kept private and secured.

#admin_listen_ssl = 0.0.0.0:8444 # Address and port on which Kong will accept
                                 # HTTPS requests to the admin API, if
                                 # `admin_ssl` is enabled.

#nginx_worker_processes = auto   # Determines the number of worker processes
                                 # spawned by Nginx.

#nginx_daemon = on               # Determines wether Nginx will run as a daemon
                                 # or as a foreground process. Mainly useful
                                 # for development or when running Kong inside
                                 # a Docker environment.

#mem_cache_size = 128m           # Size of the in-memory cache for database
                                 # entities. The accepted units are `k` and
                                 # `m`, with a minimum recommended value of
                                 # a few MBs.

#ssl = on                        # Determines if Nginx should be listening for
                                 # HTTPS traffic on the `proxy_listen_ssl`
                                 # address. If disabled, Nginx will only bind
                                 # itself on `proxy_listen`, and all SSLslkds

                                 # settings will be ignored.

#ssl_cert =                      # If `ssl` is enabled, the absolute path to
                                 # the SSL certificate for the
                                 # `proxy_listen_ssl` address.

#ssl_cert_key =                  # If `ssl` is enabled, the absolute path to
                                 # the SSL key for the `proxy_listen_ssl`
                                 # address.

#admin_ssl = on                  # Determines if Nginx should be listening for
                                 # HTTPS traffic on the `admin_listen_ssl`
                                 # address. If disabled, Nginx will only bind
                                 # itself on `admin_listen`, and all SSL
                                 # settings will be ignored.

#admin_ssl_cert =                # If `admin_ssl` is enabled, the absolute path
                                 # to the SSL certificate for the
                                 # `admin_listen_ssl` address.

#admin_ssl_cert_key =            # If `admin_ssl` is enabled, the absolute path
                                 # to the SSL key for the `admin_listen_ssl`
                                 # address.

#upstream_keepalive = 60         # Sets the maximum number of idle keepalive
                                 # connections to upstream servers that are
                                 # preserved in the cache of each worker
                                 # process. When this number is exceeded, the
                                 # least recently used connections are closed.

#server_tokens = on              # Enables or disables emitting Kong version on
                                 # error pages and in the "Server" or "Via"
                                 # (in case the request was proxied) response
                                 # header field.

#latency_tokens = on             # Enables or disables emitting Kong latency
                                 # information in the "X-Kong-Proxy-Latency"
                                 # and "X-Kong-Upstream-Latency" response
                                 # header fields.

```

---
### Datastore Section 
This section is for Datastore(Database) configurations. For example, you can customize the  PostgreSQL or Cassandra DB paramaters. 
```java
#------------------------------------------------------------------------------
# DATASTORE
#------------------------------------------------------------------------------

# Kong will store all of its data (such as APIs, consumers and plugins) in
# either Cassandra or PostgreSQL.
#
# All Kong nodes belonging to the same cluster must connect themselves to the
# same database.

#database = postgres             # Determines which of PostgreSQL or Cassandra
                                 # this node will use as its datastore.
                                 # Accepted values are `postgres` and
                                 # `cassandra`.

#pg_host = 127.0.0.1             # The PostgreSQL host to connect to.
#pg_port = 5432                  # The port to connect to.
#pg_user = kong                  # The username to authenticate if required.
#pg_password =                   # The password to authenticate if required.
#pg_database = kong              # The database name to connect to.

#pg_ssl = off                    # Toggles client-server TLS connections
                                 # between Kong and PostgreSQL.

#pg_ssl_verify = off             # Toggles server certificate verification if
                                 # `pg_ssl` is enabled.
                                 # See the `lua_ssl_trusted_certificate`
                                 # setting to specify a certificate authority.

#cassandra_contact_points = 127.0.0.1  # A comma-separated list of contact
                                       # points to your cluster.

#cassandra_port = 9042           # The port on which your nodes are listening
                                 # on. All your nodes and contact points must
                                 # listen on the same port.

#cassandra_keyspace = kong       # The keyspace to use in your cluster.

#cassandra_timeout = 5000        # Defines the timeout (in ms), for reading
                                 # and writing.

#cassandra_ssl = off             # Toggles client-to-node TLS connections
                                 # between Kong and Cassandra.

#cassandra_ssl_verify = off      # Toggles server certificate verification if
                                 # `cassandra_ssl` is enabled.
                                 # See the `lua_ssl_trusted_certificate`
                                 # setting to specify a certificate authority.

#cassandra_username = kong       # Username when using the
                                 # `PasswordAuthenticator` scheme.

#cassandra_password =            # Password when using the
                                 # `PasswordAuthenticator` scheme.

#cassandra_consistency = ONE     # Consistency setting to use when reading/
                                 # writing to the Cassandra cluster.

#cassandra_lb_policy = RoundRobin  # Load balancing policy to use when
                                   # distributing queries across your Cassandra
                                   # cluster.
                                   # Accepted values are `RoundRobin` and
                                   # `DCAwareRoundRobin`.
                                   # Prefer the later if and only if you are
                                   # using a multi-datacenter cluster.

#cassandra_local_datacenter =    # When using the `DCAwareRoundRobin` load
                                 # balancing policy, you must specify the name
                                 # of the local (closest) datacenter for this
                                 # Kong node.

#cassandra_repl_strategy = SimpleStrategy  # When migrating for the first time,
                                           # Kong will use this setting to
                                           # create your keyspace.
                                           # Accepted values are
                                           # `SimpleStrategy` and
                                           # `NetworkTopologyStrategy`.

#cassandra_repl_factor = 1       # When migrating for the first time, Kong
                                 # will create the keyspace with this
                                 # replication factor when using the
                                 # `SimpleStrategy`.

#cassandra_data_centers = dc1:2,dc2:3  # When migrating for the first time,
                                       # will use this setting when using the
                                       # `NetworkTopologyStrategy`.
                                       # The format is a comma-separated list
                                       # made of <dc_name>:<repl_factor>.

#cassandra_schema_consensus_timeout = 10000  # Defines the timeout (in ms) for
                                             # the waiting period to reach a
                                             # schema consensus between your
                                             # Cassandra nodes.
                                             # This value is only used during
                                             # migrations.
```

----
### Datastore Cache
In order to avoid unecessary communication with the datastore, Kong caches entities (such as APIs, Consumers, Credentials...) for a configurable period of time. It also handles invalidations if such an entity is updated.

This section allows for configuring the behavior of Kong regarding the caching of such configuration entities. 

```java
#------------------------------------------------------------------------------
# DATASTORE CACHE
#------------------------------------------------------------------------------
# In order to avoid unecessary communication with the datastore, Kong caches
# entities (such as APIs, Consumers, Credentials...) for a configurable period
# of time. It also handles invalidations if such an entity is updated.
#
# This section allows for configuring the behavior of Kong regarding the
# caching of such configuration entities.

#db_update_frequency = 5         # Frequency (in seconds) at which to check for
                                 # updated entities with the datastore.
                                 # When a node creates, updates, or deletes an
                                 # entity via the Admin API, other nodes need
                                 # to wait for the next poll (configured by
                                 # this value) to eventually purge the old
                                 # cached entity and start using the new one.

#db_update_propagation = 0       # Time (in seconds) taken for an entity in the
                                 # datastore to be propagated to replica nodes
                                 # of another datacenter.
                                 # When in a distributed environment such as
                                 # a multi-datacenter Cassandra cluster, this
                                 # value should be the maximum number of
                                 # seconds taken by Cassandra to propagate a
                                 # row to other datacenters.
                                 # When set, this property will increase the
                                 # time taken by Kong to propagate the change
                                 # of an entity.
                                 # Single-datacenter setups or PostgreSQL
                                 # servers should suffer no such delays, and
                                 # this value can be safely set to 0.

#db_cache_ttl = 3600             # Time-to-live (in seconds) of an entity from
                                 # the datastore when cached by this node.
                                 # Database misses (no entity) are also cached
                                 # according to this setting.
                                 # If set to 0, such cached entities/misses
                                 # never expire.
```

---

<!---
As of Kong version 0.11.0 clustering is removed since Kong stateless (removed by commenting out)

### Clustering Section
This section is for Clustering. For example, you can specify the Topology type, such as Simple or Network Topology Strategy. 

```java

#------------------------------------------------------------------------------
# CLUSTERING
#------------------------------------------------------------------------------

# In addition to pointing to the same database, each Kong node must be
# reachable by the other nodes in the cluster.
#
# Kong's clustering works on the IP layer (hostnames are not supported, only
# IPs) and expects a flat network topology without any NAT between the
# datacenters.
#
# A common pattern is to create a VPN between the two datacenters such that
# the flat network assumption is not violated.
#
# See the clustering reference for more informations:
# https://getkong.org/docs/latest/clustering/

#cluster_listen = 0.0.0.0:7946   # Address and port used to communicate with
                                 # other nodes in the cluster.
                                 # All other Kong nodes in the same cluster
                                 # must be able to communicate over both
                                 # TCP and UDP on this address.
                                 # Only IPv4 addresses are supported.

#cluster_listen_rpc = 127.0.0.1:7373  # Address and port used to communicate
                                      # with the cluster through the agent
                                      # running on this node. Only contains
                                      # TCP traffic local to this node.

#cluster_advertise =             # By default, the `cluster_listen` address
                                 # is advertised over the cluster.
                                 # If the `cluster_listen` host is '0.0.0.0',
                                 # then the first local, non-loopback IPv4
                                 # address will be advertised to other nodes.
                                 # However, in some cases (specifically NAT
                                 # traversal), there may be a routable address
                                 # that cannot be bound to. This flag enables
                                 # advertising a different address to support
                                 # this.

#cluster_encrypt_key =           # base64-encoded 16-bytes key to encrypt
                                 # cluster traffic with.

#cluster_keyring_file =          # Specifies a file to load keyring data from.
                                 # Kong is able to keep encryption keys in sync
                                 # and perform key rotations. During a key
                                 # rotation, there may be some period of time
                                 # in which Kong is required to maintain more
                                 # than one encryption key until all members
                                 # have received the new key.

#cluster_ttl_on_failure = 3600   # Time to live (in seconds) of a node in the
                                 # cluster when it stops sending healthcheck
                                 # pings, possibly caused by a node or network
                                 # failure.
                                 # If a node is not able to send a new
                                 # healthcheck ping before the expiration,
                                 # other nodes in the cluster will stop
                                 # attempting to connect to it.
                                 # Recommended to be at least `60`.

#cluster_profile = wan           # The timing profile for inter-cluster pings
                                 # and timeouts. If a `lan` or `local` profile
                                 # is used over the Internet, a high rate of
                                 # failures is risked as the timing contraints
                                 # would be too tight.
                                 # Accepted values are `local`, `lan`, `wan`.
```
----
--->

### DNS Resolver Section 

```java
#------------------------------------------------------------------------------
# DNS RESOLVER
#------------------------------------------------------------------------------

#dns_resolver =                  # Comma separated list of nameservers, each
                                 # entry in `ipv4[:port]` format to be used by
                                 # Kong. If not specified the nameservers in
                                 # the local `resolv.conf` file will be used.
                                 # Port defaults to 53 if omitted.

#dns_hostsfile = /etc/hosts      # The hosts file to use. This file is read
                                 # once and its content is static in memory.
                                 # To read the file again after modifying it,
                                 # Kong must be reloaded.

```

----


### Development and Miscellaneous Section
This section is for Development and Misc configurations. For example, you can modify the database certificate path. 


```java

#------------------------------------------------------------------------------
# DEVELOPMENT & MISCELLANEOUS
#------------------------------------------------------------------------------

# Additional settings inherited from lua-nginx-module allowing for more
# flexibility and advanced usage.
#
# See the lua-nginx-module documentation for more informations:
# https://github.com/openresty/lua-nginx-module

#lua_ssl_trusted_certificate =   # Absolute path to the certificate
                                 # authority file for Lua cosockets in PEM
                                 # format. This certificate will be the one
                                 # used for verifying Kong's database
                                 # connections, when `pg_ssl_verify` or
                                 # `cassandra_ssl_verify` are enabled.

#lua_ssl_verify_depth = 1        # Sets the verification depth in the server
                                 # certificates chain used by Lua cosockets,
                                 # set by `lua_ssl_trusted_certificate`.
                                 # This includes the certificates configured
                                 # for Kong's database connections.

#lua_code_cache = on             # When disabled, every request will run in a
                                 # separate Lua VM instance: all Lua modules
                                 # will be loaded from scratch. Useful for
                                 # adopting an edit-and-refresh approach while
                                 # developing a plugin.
                                 # Turning this directive off has a severe
                                 # impact on performance.

#lua_package_path =              # Sets the Lua module search path (LUA_PATH).
                                 # Useful when developing or using custom
                                 # plugins not stored in the default search
                                 # path.

#lua_package_cpath =             # Sets the Lua C module search path
                                 # (LUA_CPATH).

#lua_socket_pool_size = 30       # Specifies the size limit for every cosocket
                                 # connection pool associated with every remote
                                 # server
```



----

## **Summary**
The Kong configuration is essential to customize and optimize your environment. This file allows you to make changes to general configurations, NGINX, Kong, and Database specific parameters. It also allows you to make changes to some of the LUA paramaters. Becoming familar with this file is important part of your Kong training.  We will modify this file in subsequent labs.

## What Next
Lets explore the log files to help troubleshoot your environment. 

#### [Explore Kong Log Files](https://simplru.gelato.io/guides/explore-kong-system-log-files)





