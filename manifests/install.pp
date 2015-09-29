class globus::install {

  package { $globus::params::globus_connect_server_package:
    ensure  => present,
    require => Class['globus::repo']
  }

}