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
      $globus_user                          = '%(GLOBUS_USER)s'
      $globus_password                      = '%(GLOBUS_PASSWORD)s'
      $endpoint_name                        = '%(SHORT_HOSTNAME)s'
      $endpoint_defaultdirectory            = '/~/'
      $endpoint_public                      = 'False'
      $security_authorizationmethod         = undef
      $security_certificatefile             = undef
      $security_cilogonidentityprovider     = undef
      $security_fetchcredentialfromrelay    = 'True'
      $security_gridmap                     = undef
      $security_identitymethod              = 'MyProxy'
      $security_keyfile                     = undef
      $security_trustedcertificatedirectory = undef
      $gridftp_datainterface                = undef
      $gridftp_incomingportrange            = undef
      $gridftp_outgoingportrange            = undef
      $gridftp_restrictpaths                = undef
      $gridftp_server                       = '%(HOSTNAME)s'
      $gridftp_serverbehindnat              = undef
      $gridftp_sharing                      = undef
      $gridftp_sharinggroupsallow           = undef
      $gridftp_sharinggroupsdeny            = undef
      $gridftp_sharingrestrictpaths         = undef
      $gridftp_sharingstatedir              = undef
      $gridftp_sharingusersallow            = undef
      $gridftp_sharingusersdeny             = undef
      $myproxy_cadirectory                  = undef
      $myproxy_configfile                   = undef
      $myproxy_server                       = '%(HOSTNAME)s'
      $myproxy_serverbehindnat              = undef
      $oauth_logo                           = undef
      $oauth_server                         = undef
      $oauth_serverbehindnat                = undef
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}