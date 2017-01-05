# globus

## Overview

Install and manage Globus Connect Server and Endpoint.

## Module Description

[Globus Connect Server](https://www.globus.org/globus-connect-server) provides file transfer
and sharing between Endpoints. This module installs and configures the requisite software and
sets up an endpoint. It is modeled on the instructions in the
[Globus Resource Provider Guide](http://dev.globus.org/resource-provider-guide/).

## Setup

### What globus affects

* Installs a YUM configuration for the Globus Toolkit repository
* Installs the `globus-connect-server` package and its dependencies
* Configures Connect Server and an Endpoint
  * sub-component configurations (GridFTP, MyProxy) are optional
* Runs the Globus `globus-connect-server-setup` command to setup and start services

See the [Globus Resource Provider Guide](http://dev.globus.org/resource-provider-guide/)
for details.

### Setup Requirements

The [stahma/epel](http://github.com/stahnma/puppet-module-epel) Puppet module is required.

The command `hostname -f` on the host must return a valid, public FQDN;
otherwise, the `globus-simple-ca` package will not correctly generate
certificates.

Open firewall ports as documented in the
[Globus Resource Provider Guide](http://dev.globus.org/resource-provider-guide/#open-tcp-ports).

### Beginning with globus

_Be sure the host's public IP address will DNS-reverses to the public hostname.
Otherwise MyProxy authentications are likely to fail._

In the appropriate manifest,

    include globus_connect_server

will install a Connect Server and configure with default values.

At a minimum you will need to set Globus login credentials in your Hiera configuration.

    globus_connect_server::config::gcs_globus_user: 'eupathdb'
    globus_connect_server::config::gcs_globus_password: 'slfdj02sdil'

By default, the server will be configured to use login credentials from
`GLOBUS_USER` and `GLOBUS_PASSWORD` environment variables. That is,
`/etc/globus-connect-server.conf` will specify `User = %(GLOBUS_USER)s`
and `Password = %(GLOBUS_PASSWORD)s`. If you prefer the less secure
method of having username and password as clear-text in the
configuration file then disable this default in hiera:

    globus_connect_server::config::gcs_use_env_credentials: false

## Usage

    include globus_connect_server

## Hiera Parameters

**`globus_connect_server::ensure`** - `'enabled'`, the default, installs, configures and
starts Connect Server services. `'absent'` or `'disabled`' stops
services and removes `globus-*` packages and most Globus-related files.
Warning: disabling will also remove MyProxy and that may not be desired if the node
is meant to provide that single service.

### Hiera Parameters affecting Globus Connect Server configuration

The `/etc/globus-connect-server.conf` file controls the basic Connect
Server configuration. The settings in this file can be defined through
Hiera parameters. These parameters are in the
`globus_connect_server::config::` namespace. The Hiera parameter format
is lower-cased `{section}_gcs_{setting}`. For example, the Hiera
parameter

    globus_connect_server::config::gcs_endpoint_name: DataSets

will set the value

    [ENDPOINT]
    Name =  DataSets

in the `globus-connect-server.conf` file. The
`globus-connect-server.conf` file and Globus documentation has complete
information for each setting.

You must define user and password values.

**`globus_connect_server::config::gcs_globus_user`**

**`globus_connect_server::config::gcs_globus_password`**

These required parameter are the username and password of the Globus
user that will be used when creating or updating the endpoint definition.

See the `globus_connect_server::config` class for the full list of
other parameter options.

### Hiera Parameters affecting GridFTP logging

By default, GridFTP logging is configured using default values and
typically can be left as is.

**`globus_connect_server::config::gridftp_server_log`** - sets the location of the
log file. Defaults to `/var/log/gridftp.log`

**`globus_connect_server::config::gridftp_log_level`** - defines the log level. Defaults to `ERROR,WARN`.
_Notice: Running `globus-connect-server-setup` will revert the log level
to the default value. This module accounts for this but be aware if manually running setup._

### Hiera Parameters affecting MyProxy Server logging

**`globus_connect_server::config::myproxy_server_log`** - allows changing the location
of the log file for MyProxy. MyProxy logging uses rsyslog and defaults
to `/var/log/messages`; setting the parameter will add a configuration
to `/etc/rsyslog.d/` to change the logging.

## Limitations

Only supported on the RedHat OS family.

