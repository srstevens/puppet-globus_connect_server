# Uninstall most Globus Connect Server packages and files
class globus::uninstall {

  exec { 'globus-connect-server-io-cleanup':
    path   => '/bin:/usr/bin:/sbin:/usr/sbin',
    onlyif => 'test -f /usr/bin/globus-connect-server-io-cleanup'
  } ->
  exec { 'globus-connect-server-id-cleanup':
    path   => '/bin:/usr/bin:/sbin:/usr/sbin',
    onlyif => 'test -f /usr/bin/globus-connect-server-id-cleanup'
  } ->
  exec { 'globus-connect-server-web-cleanup':
    path   => '/bin:/usr/bin:/sbin:/usr/sbin',
    onlyif => 'test -f /usr/bin/globus-connect-server-web-cleanup'
  }

  package { 'globus-*':
    ensure  => purged,
    require => Exec['globus-connect-server-web-cleanup'],
  }

  file { [
    '/var/lib/globus',
    '/var/lib/globus-connect-server',
    '/etc/grid-security',
    '/usr/share/globus',
    '/usr/lib64/globus',
  ]:
    ensure  => absent,
    recurse => true,
    purge   => true,
    force   => true,
    require => Package['globus-*'],
  }

}