# manage GridFTP service
class globus_connect_server::service {

  service { 'globus-gridftp-server':
    ensure => running,
    enable => true,
  }
}