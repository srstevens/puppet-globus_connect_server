class globus::params {

  case $::osfamily {
    'RedHat': {
      $globus_yumrepo_rpm = 'http://toolkit.globus.org/ftppub/globus-connect-server/globus-connect-server-repo-latest.noarch.rpm'
      $globus_connect_server_package = 'globus-connect-server'
      $globus_connect_server_conf = '/etc/globus-connect-server.conf'
      $service_name       = 'globus-gridftp-server'
      $service_hasstatus  = true
      $service_hasrestart = true
      $config_path        = '/etc/globus-connect-server.conf'
      
      # variable format: section_parameter. e.g.
      #   [Globus]
      #   User
      # is $globus_user
      $globus_user   = '%(GLOBUS_USER)s'
      $globus_password = '%(GLOBUS_PASSWORD)s'
      $endpoint_name = '%(SHORT_HOSTNAME)s'
      $endpoint_public = 'False'
      $endpoint_defaultdirectory = '/~/'
      $security_fetchcredentialfromrelay = 'True'
      $security_identitymethod = 'MyProxy'
      $gridftp_server = '%(HOSTNAME)s'
      $myproxy_server = '%(HOSTNAME)s'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}