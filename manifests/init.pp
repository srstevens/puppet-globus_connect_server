# install Globus Connect Server
class globus_connect_server (
  String $ensure = 'enabled'
) {

  include ::globus_connect_server::params
  include ::globus_connect_server::config

  if $ensure == 'enabled' {
    include ::globus_connect_server::repo
    include ::globus_connect_server::install
    include ::globus_connect_server::service
    Class['::globus_connect_server::repo'] ->
    Class['::globus_connect_server::install'] ->
    Class['::globus_connect_server::config'] ~>
    Class['::globus_connect_server::service']
  } elsif ($ensure == 'disabled' or $ensure == 'absent') {
    include ::globus_connect_server::uninstall
  } else {
    fail('expected ensure to be enabled, disabled or absent')
  }
}
