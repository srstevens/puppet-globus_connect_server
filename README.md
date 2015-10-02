# globus

## Overview

Install and manage Globus Connect Server and Endpoint.

## Module Description

[Globus Connect Server](https://www.globus.org/globus-connect-server) provides file transfer
and sharing between Endpoints. This module installs and configures the requisite software and
sets up an endpoint, based on the instructions in the
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

In the appropriate manifest,

    include globus

will install a Connect Server and configure with default values. More than likely you
will want to minimally set login credentials and an endpoint name via Hiera

    globus::config::gcs_globus_user: 'eupathdb'
    globus::config::gcs_globus_password: 'slfdj02sdil'
    globus::config::gcs_endpoint_name: 'data'

In my experience, the GridFTP MyProxy hostname needs to be explicitly set unless the 
FQDN and public IP are set in `/etc/hosts`.

    globus::config::gcs_gridftp_server: 'gc.example.org'
    globus::config::gcs_gridftp_serverbehindnat: 'True'
    globus::config::gcs_myproxy_server: 'gc.example.org'
    globus::config::gcs_myproxy_serverbehindnat: 'True'

## Usage

    include globus

## Hiera Parameters

**globus::ensure** - `'enabled'`, the default, installs, configures and
starts Connect Server services. `'absent'` or `'disabled`' stops
services and removes `globus-*` packages and most Globus-related files.
Disabling will also remove MyProxy which may not be desired if the node
is meant to provide that single service.

### Hiera Parameters affecting Globus Connect Server configuration

Hiera parameters for configuring a Connect Server are in the `globus::config::` namespace.

See the `globus::config` class for the full list of parameters.

The `/etc/globus-connect-server.conf` file controls the basic Connect
Server configuration. The settings in this file can be defined through Hiera parameters.
The Hiera parameter format is lower-cased `section\_gcs\_setting`. For
example, the Hiera parameter `globus::config::gcs_endpoint\_name: DataSets`
will set the value

    [ENDPOINT]
    Name =  DataSets

in the `globus-connect-server.conf` file. The `globus-connect-server.conf` file has
complete documentation for each setting.

### Hiera Parameters affecting GridFTP logging

By default, GridFTP logging is configured using default values and
typically can be left as is.

**globus::config::gridftp\_server\_log_conf** - sets the location of the
configuration file for GridFTP logging. Defaults to
`/var/lib/globus-connect-server/gridftp.d/globus-connect-server-gridftp-logging`.

**globus::config::gridftp\_server\_log** - sets the location of the
log file. Defaults to
`/etc/gridftp.d/globus-connect-server-gridftp-logging`

**globus::config::gridftp\_log\_level** - defines the log level. Defaults to `ERROR,WARN`

### Hiera Parameters affecting MyProxy Server logging

**globus::config::myproxy\_server\_log** - allows changing the location
of the log file for MyProxy. MyProxy logging uses rsyslog and defaults
to `/var/log/messages`; setting the parameter will add a configuration
to `/etc/rsyslog.d/` to change the logging.

## Limitations

Only supported on the RedHat OS family.

