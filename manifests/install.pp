# Install Globus packages
class globus_connect_server::install {

  include ::epel

  package { $globus_connect_server::params::globus_connect_server_package:
    ensure  => present,
    require => [
      Class['epel'],
      Class['globus_connect_server::repo']
    ],
  }

}