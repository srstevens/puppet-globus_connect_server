# install Globus Connect Server
class globus_connect_server (
  $ensure = 'enabled'
) {

  include ::globus_connect_server::params

  if $ensure == 'enabled' {
    class { '::globus_connect_server::repo': } ->
    class { '::globus_connect_server::install': } ->
    class { '::globus_connect_server::config': } ~>
    class { '::globus_connect_server::service': }
  } elsif ($ensure == 'disabled' or $ensure == 'absent') {
    class { '::globus_connect_server::uninstall': }
  } else {
    fail('expected ensure to be enabled, disabled or absent')
  }
}
