class globus::config(
  $globus_user = $globus::params::globus_user,
  $globus_password = $globus::params::globus_password,
  $endpoint_name = $globus::params::endpoint_name,
  $endpoint_public = $globus::params::endpoint_public,
  $endpoint_defaultdirectory = $globus::params::endpoint_defaultdirectory,
  $security_fetchcredentialfromrelay = $globus::params::security_fetchcredentialfromrelay,
  $security_identitymethod = $globus::params::security_identitymethod,
  $gridftp_server = $globus::params::gridftp_server,
  $myproxy_server = $globus::params::myproxy_server,
  $oauth_logo = undef,
) {

  include globus::params

  $globus_connect_server_conf = $globus::params::globus_connect_server_conf
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