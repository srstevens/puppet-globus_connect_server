class globus::config(
  $globus_password                      = $globus::params::globus_password,
  $globus_user                          = $globus::params::globus_user,
  $endpoint_defaultdirectory            = $globus::params::endpoint_defaultdirectory,
  $endpoint_name                        = $globus::params::endpoint_name,
  $endpoint_public                      = $globus::params::endpoint_public,
  $security_authorizationmethod         = $globus::params::security_authorizationmethod,
  $security_certificatefile             = $globus::params::security_certificatefile,
  $security_cilogonidentityprovider     = $globus::params::security_cilogonidentityprovider,
  $security_fetchcredentialfromrelay    = $globus::params::security_fetchcredentialfromrelay,
  $security_gridmap                     = $globus::params::security_gridmap,
  $security_identitymethod              = $globus::params::security_identitymethod,
  $security_keyfile                     = $globus::params::security_keyfile,
  $security_trustedcertificatedirectory = $globus::params::security_trustedcertificatedirectory,
  $gridftp_datainterface                = $globus::params::gridftp_datainterface,
  $gridftp_incomingportrange            = $globus::params::gridftp_incomingportrange,
  $gridftp_outgoingportrange            = $globus::params::gridftp_outgoingportrange,
  $gridftp_restrictpaths                = $globus::params::gridftp_restrictpaths,
  $gridftp_server                       = $globus::params::gridftp_server,
  $gridftp_serverbehindnat              = $globus::params::gridftp_serverbehindnat,
  $gridftp_sharing                      = $globus::params::gridftp_sharing,
  $gridftp_sharinggroupsallow           = $globus::params::gridftp_sharinggroupsallow,
  $gridftp_sharinggroupsdeny            = $globus::params::gridftp_sharinggroupsdeny,
  $gridftp_sharingrestrictpaths         = $globus::params::gridftp_sharingrestrictpaths,
  $gridftp_sharingstatedir              = $globus::params::gridftp_sharingstatedir,
  $gridftp_sharingusersallow            = $globus::params::gridftp_sharingusersallow,
  $gridftp_sharingusersdeny             = $globus::params::gridftp_sharingusersdeny,
  $myproxy_cadirectory                  = $globus::params::myproxy_cadirectory,
  $myproxy_configfile                   = $globus::params::myproxy_configfile,
  $myproxy_server                       = $globus::params::myproxy_server,
  $myproxy_serverbehindnat              = $globus::params::myproxy_serverbehindnat,
  $oauth_logo                           = $globus::params::oauth_logo,
  $oauth_server                         = $globus::params::oauth_server,
  $oauth_serverbehindnat                = $globus::params::oauth_serverbehindnat,
) {

  include globus::params

  $globus_connect_server_conf    = $globus::params::globus_connect_server_conf
  $globus_connect_server_package = $globus::params::globus_connect_server_package

  file { $globus_connect_server_conf:
    ensure  => present,
    content => template('globus/globus-connect-server.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$globus_connect_server_package],
    notify => Exec['globus-connect-server-setup'],
  }

  exec { 'globus-connect-server-setup':
    path    => '/bin:/usr/bin:/sbin:/usr/sbin',
    command => 'globus-connect-server-setup',
    refreshonly => true,
  }

}