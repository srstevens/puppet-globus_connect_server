# Configure Globus endpoint and affiliated services and logging
class globus_connect_server::config (
  # globus-connect-server.conf settings
  String           $gcs_globus_password                      = '%(GLOBUS_PASSWORD)s',
  String           $gcs_globus_user                          = '%(GLOBUS_USER)s',
  String           $gcs_endpoint_defaultdirectory            = $globus_connect_server::params::gcs_endpoint_defaultdirectory,
  String           $gcs_endpoint_name                        = $globus_connect_server::params::gcs_endpoint_name,
  String           $gcs_endpoint_public                      = $globus_connect_server::params::gcs_endpoint_public,
  Optional[String] $gcs_security_authorizationmethod         = $globus_connect_server::params::gcs_security_authorizationmethod,
  Optional[String] $gcs_security_certificatefile             = $globus_connect_server::params::gcs_security_certificatefile,
  Optional[String] $gcs_security_cilogonidentityprovider     = $globus_connect_server::params::gcs_security_cilogonidentityprovider,
  String           $gcs_security_fetchcredentialfromrelay    = $globus_connect_server::params::gcs_security_fetchcredentialfromrelay,
  Optional[String] $gcs_security_gridmap                     = $globus_connect_server::params::gcs_security_gridmap,
  String           $gcs_security_identitymethod              = $globus_connect_server::params::gcs_security_identitymethod,
  Optional[String] $gcs_security_keyfile                     = $globus_connect_server::params::gcs_security_keyfile,
  Optional[String] $gcs_security_trustedcertificatedirectory = $globus_connect_server::params::gcs_security_trustedcertificatedirectory,
  Optional[String] $gcs_gridftp_datainterface                = $globus_connect_server::params::gcs_gridftp_datainterface,
  String           $gcs_gridftp_incomingportrange            = $globus_connect_server::params::gcs_gridftp_incomingportrange,
  String           $gcs_gridftp_outgoingportrange            = $globus_connect_server::params::gcs_gridftp_outgoingportrange,
  Array            $gcs_gridftp_restrictpaths                = $globus_connect_server::params::gcs_gridftp_restrictpaths,
  String           $gcs_gridftp_server                       = $globus_connect_server::params::gcs_gridftp_server,
  Optional[String] $gcs_gridftp_serverbehindnat              = $globus_connect_server::params::gcs_gridftp_serverbehindnat,
  Optional[String] $gcs_gridftp_sharing                      = $globus_connect_server::params::gcs_gridftp_sharing,
  Array            $gcs_gridftp_sharinggroupsallow           = $globus_connect_server::params::gcs_gridftp_sharinggroupsallow,
  Array            $gcs_gridftp_sharinggroupsdeny            = $globus_connect_server::params::gcs_gridftp_sharinggroupsdeny,
  Optional[Array]  $gcs_gridftp_sharingrestrictpaths         = $globus_connect_server::params::gcs_gridftp_sharingrestrictpaths,
  Optional[String] $gcs_gridftp_sharingstatedir              = $globus_connect_server::params::gcs_gridftp_sharingstatedir,
  Array            $gcs_gridftp_sharingusersallow            = $globus_connect_server::params::gcs_gridftp_sharingusersallow,
  Array            $gcs_gridftp_sharingusersdeny             = $globus_connect_server::params::gcs_gridftp_sharingusersdeny,
  Integer          $gsc_gridftp_control_channel_port         = $globus_connect_server::params::gsc_gridftp_control_channel_port,
  Optional[String] $gcs_myproxy_cadirectory                  = $globus_connect_server::params::gcs_myproxy_cadirectory,
  Optional[String] $gcs_myproxy_configfile                   = $globus_connect_server::params::gcs_myproxy_configfile,
  String           $gcs_myproxy_server                       = $globus_connect_server::params::gcs_myproxy_server,
  Integer          $gcs_myproxy_port                         = $globus_connect_server::params::gcs_myproxy_port,
  Optional[String] $gcs_myproxy_serverbehindnat              = $globus_connect_server::params::gcs_myproxy_serverbehindnat,
  Optional[String] $gcs_oauth_logo                           = $globus_connect_server::params::gcs_oauth_logo,
  Optional[String] $gcs_oauth_server                         = $globus_connect_server::params::gcs_oauth_server,
  Optional[String] $gcs_oauth_serverbehindnat                = $globus_connect_server::params::gcs_oauth_serverbehindnat,

  # Other  
  String           $globus_connect_server_package = $globus_connect_server::params::globus_connect_server_package,
  String           $globus_connect_server_conf    = $globus_connect_server::params::globus_connect_server_conf,
  String           $globus_connect_gridftp_conf   = $globus_connect_server::params::globus_connect_gridftp_conf,
  String           $globus_connect_gridftp_gfork  = $globus_connect_server::params::globus_connect_gridftp_gfork,
  String           $gridftp_server_log            = $globus_connect_server::params::gridftp_server_log,
  String           $gridftp_log_level             = $globus_connect_server::params::gridftp_log_level,
  Optional[String] $myproxy_server_log            = $globus_connect_server::params::myproxy_server_log,
) {

  include ::globus_connect_server::params

  file { $globus_connect_server_conf:
    ensure  => present,
    content => template('globus_connect_server/globus-connect-server.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    require => Package[$globus_connect_server_package],
    notify  => Exec['globus-connect-server-setup'],
  }

  file { $globus_connect_gridftp_conf:
    ensure  => present,
    content => template('globus_connect_server/globus-connect-server-gridftp.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$globus_connect_server_package],
    notify  => Exec['globus-connect-server-setup'],
  }

  file { $globus_connect_gridftp_gfork:
    ensure  => present,
    content => template('globus_connect_server/globus-connect-server-gridftp.gfork.erb'),
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
    environment => [ "HOME=${::root_home}",
                   "GLOBUS_USER=${::globus_connect_server::params::gcs_globus_user}",
                   "GLOBUS_PASSWORD=${::globus_connect_server::params::gcs_globus_password}",
                   ],
    refreshonly => true,
  }

  if ! defined(Service['rsyslog']) {
    service { 'rsyslog':
      ensure => 'running',
      enable => true,
    }
  }

}
