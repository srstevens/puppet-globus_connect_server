# Install Globus packages
class globus_connect_server::install {

  package { $globus_connect_server::params::globus_connect_server_package:
    ensure  => present,
    require => Class['globus_connect_server::repo'],
  }

}