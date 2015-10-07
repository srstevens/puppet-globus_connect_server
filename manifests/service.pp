# manage GridFTP service
class globus::service {

  service { 'globus-gridftp-server':
    ensure => running,
    enable => true,
  }
}