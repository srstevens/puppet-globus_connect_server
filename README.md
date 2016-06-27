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

will install a Connect Server and configure with default values. More than likely you
will want to minimally set login credentials and an endpoint name via Hiera

    globus_connect_server::config::gcs_globus_user: 'eupathdb'
    globus_connect_server::config::gcs_globus_password: 'slfdj02sdil'
    globus_connect_server::config::gcs_endpoint_name: 'data'

## Usage

    include globus_connect_server

## Hiera Parameters

**globus_connect_server::ensure** - `'enabled'`, the default, installs, configures and
starts Connect Server services. `'absent'` or `'disabled`' stops
services and removes `globus-*` packages and most Globus-related files.
Warning: disabling will also remove MyProxy and that may not be desired if the node
is meant to provide that single service.

### Hiera Parameters affecting Globus Connect Server configuration

Hiera parameters for configuring a Connect Server are in the `globus_connect_server::config::` namespace.

See the `globus_connect_server::config` class for the full list of parameters.

The `/etc/globus-connect-server.conf` file controls the basic Connect
Server configuration. The settings in this file can be defined through Hiera parameters.
The Hiera parameter format is lower-cased `section_gcs_setting`. For
example, the Hiera parameter `globus_connect_server::config::gcs_endpoint_name: DataSets`
will set the value

    [ENDPOINT]
    Name =  DataSets

in the `globus-connect-server.conf` file. The `globus-connect-server.conf` file has
complete documentation for each setting.

### Hiera Parameters affecting GridFTP logging

By default, GridFTP logging is configured using default values and
typically can be left as is.

**globus_connect_server::config::gridftp\_server\_log** - sets the location of the
log file. Defaults to `/var/log/gridftp.log`

**globus_connect_server::config::gridftp\_log\_level** - defines the log level. Defaults to `ERROR,WARN`.
_Notice: Running `globus-connect-server-setup` will revert the log level
to the default value. This module accounts for this but be aware if manually running setup._

### Hiera Parameters affecting MyProxy Server logging

**globus_connect_server::config::myproxy\_server\_log** - allows changing the location
of the log file for MyProxy. MyProxy logging uses rsyslog and defaults
to `/var/log/messages`; setting the parameter will add a configuration
to `/etc/rsyslog.d/` to change the logging.

## Limitations

Only supported on the RedHat OS family.

