class globus::config(
  $endpoint_name = $globus::params::endpoint_name
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