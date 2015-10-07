# install Globus Connect Server
class globus (
  $ensure = 'enabled'
) {

  include globus::params

  if $ensure == 'enabled' {
    class { 'globus::repo': } ->
    class { 'globus::install': } ->
    class { 'globus::config': } ~>
    class { 'globus::service': }
  } elsif ($ensure == 'disabled' or $ensure == 'absent') {
    class { 'globus::uninstall': }
  } else {
    fail('expected ensure to be enabled, disabled or absent')
  }
}
