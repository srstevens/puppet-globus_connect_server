# Configure Globus endpoint and affiliated services and logging
class globus_connect_server::config (
  # globus-connect-server.conf settings
  $gcs_globus_password                      = $globus_connect_server::params::gcs_globus_password,
  $gcs_globus_user                          = $globus_connect_server::params::gcs_globus_user,
  $gcs_endpoint_defaultdirectory            = $globus_connect_server::params::gcs_endpoint_defaultdirectory,
  $gcs_endpoint_name                        = $globus_connect_server::params::gcs_endpoint_name,
  $gcs_endpoint_public                      = $globus_connect_server::params::gcs_endpoint_public,
  $gcs_security_authorizationmethod         = $globus_connect_server::params::gcs_security_authorizationmethod,
  $gcs_security_certificatefile             = $globus_connect_server::params::gcs_security_certificatefile,
  $gcs_security_cilogonidentityprovider     = $globus_connect_server::params::gcs_security_cilogonidentityprovider,
  $gcs_security_fetchcredentialfromrelay    = $globus_connect_server::params::gcs_security_fetchcredentialfromrelay,
  $gcs_security_gridmap                     = $globus_connect_server::params::gcs_security_gridmap,
  $gcs_security_identitymethod              = $globus_connect_server::params::gcs_security_identitymethod,
  $gcs_security_keyfile                     = $globus_connect_server::params::gcs_security_keyfile,
  $gcs_security_trustedcertificatedirectory = $globus_connect_server::params::gcs_security_trustedcertificatedirectory,
  $gcs_gridftp_datainterface                = $globus_connect_server::params::gcs_gridftp_datainterface,
  $gcs_gridftp_incomingportrange            = $globus_connect_server::params::gcs_gridftp_incomingportrange,
  $gcs_gridftp_outgoingportrange            = $globus_connect_server::params::gcs_gridftp_outgoingportrange,
  $gcs_gridftp_restrictpaths                = $globus_connect_server::params::gcs_gridftp_restrictpaths,
  $gcs_gridftp_server                       = $globus_connect_server::params::gcs_gridftp_server,
  $gcs_gridftp_serverbehindnat              = $globus_connect_server::params::gcs_gridftp_serverbehindnat,
  $gcs_gridftp_sharing                      = $globus_connect_server::params::gcs_gridftp_sharing,
  $gcs_gridftp_sharinggroupsallow           = $globus_connect_server::params::gcs_gridftp_sharinggroupsallow,
  $gcs_gridftp_sharinggroupsdeny            = $globus_connect_server::params::gcs_gridftp_sharinggroupsdeny,
  $gcs_gridftp_sharingrestrictpaths         = $globus_connect_server::params::gcs_gridftp_sharingrestrictpaths,
  $gcs_gridftp_sharingstatedir              = $globus_connect_server::params::gcs_gridftp_sharingstatedir,
  $gcs_gridftp_sharingusersallow            = $globus_connect_server::params::gcs_gridftp_sharingusersallow,
  $gcs_gridftp_sharingusersdeny             = $globus_connect_server::params::gcs_gridftp_sharingusersdeny,
  $gcs_myproxy_cadirectory                  = $globus_connect_server::params::gcs_myproxy_cadirectory,
  $gcs_myproxy_configfile                   = $globus_connect_server::params::gcs_myproxy_configfile,
  $gcs_myproxy_server                       = $globus_connect_server::params::gcs_myproxy_server,
  $gcs_myproxy_serverbehindnat              = $globus_connect_server::params::gcs_myproxy_serverbehindnat,
  $gcs_oauth_logo                           = $globus_connect_server::params::gcs_oauth_logo,
  $gcs_oauth_server                         = $globus_connect_server::params::gcs_oauth_server,
  $gcs_oauth_serverbehindnat                = $globus_connect_server::params::gcs_oauth_serverbehindnat,

  # Other  
  $globus_connect_server_package = $globus_connect_server::params::globus_connect_server_package,
  $globus_connect_server_conf    = $globus_connect_server::params::globus_connect_server_conf,
  $gridftp_server_log      = $globus_connect_server::params::gridftp_server_log,
  $gridftp_log_level      = $globus_connect_server::params::gridftp_log_level,
  $myproxy_server_log = $globus_connect_server::params::myproxy_server_log,
) {

  include ::globus_connect_server::params

  file { $globus_connect_server_conf:
    ensure  => present,
    content => template('globus_connect_server/globus-connect-server.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$globus_connect_server_package],
    notify  => Exec['globus-connect-server-setup'],
  }

  file { $globus_connect_server::params::gridftp_server_log_conf:
    ensure  => present,
    links   => 'follow',
    content => template('globus_connect_server/globus-connect-server-gridftp-logging.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    # globus-connect-server-setup overwrites the conf file, so do this after
    require => Exec['globus-connect-server-setup'],
  }

  file { '/root/globus-connect-server-setup.rsp':
    ensure  => 'file',
    content => template('globus_connect_server/globus-connect-server-setup.rsp.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
  }

  if $myproxy_server_log {
    # move MyProxy logging to its own log file.
    file { '/etc/rsyslog.d/myproxy.conf':
      ensure  => present,
      links   => 'follow',
      content => template('globus_connect_server/myproxy-rsyslog.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Service['rsyslog'],
    }
  }

  exec { 'globus-connect-server-setup':
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    command     => 'globus-connect-server-setup < /root/globus-connect-server-setup.rsp',
    environment => [ "HOME=${::root_home}" ],
    refreshonly => true,
    require     => File['/root/globus-connect-server-setup.rsp'],
  }

  if ! defined(Service['rsyslog']) {
    service { 'rsyslog':
      ensure => 'running',
      enable => true,
    }
  }

}