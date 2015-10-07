# Default parameter values
class globus::params {

  case $::osfamily {
    'RedHat': {
      $globus_yumrepo_rpm = 'http://toolkit.globus.org/ftppub/globus-connect-server/globus-connect-server-repo-latest.noarch.rpm'
      $globus_connect_server_package = 'globus-connect-server'
      $globus_connect_server_conf = '/etc/globus-connect-server.conf'

      $gridftp_service_name = 'globus-gridftp-server'
      $gridftp_server_log_conf = '/var/lib/globus-connect-server/gridftp.d/globus-connect-server-gridftp-logging'
      $gridftp_server_log = '/var/log/gridftp.log'
      $gridftp_log_level = 'ERROR,WARN'
      $myproxy_server_log = undef

      # variable format: section_parameter. e.g.
      #   [Globus]
      #   User
      # is $globus_user
      $gcs_globus_user                          = '%(GLOBUS_USER)s'
      $gcs_globus_password                      = '%(GLOBUS_PASSWORD)s'
      $gcs_endpoint_name                        = '%(SHORT_HOSTNAME)s'
      $gcs_endpoint_defaultdirectory            = '/~/'
      $gcs_endpoint_public                      = 'False'
      $gcs_security_authorizationmethod         = undef
      $gcs_security_certificatefile             = undef
      $gcs_security_cilogonidentityprovider     = undef
      $gcs_security_fetchcredentialfromrelay    = 'True'
      $gcs_security_gridmap                     = undef
      $gcs_security_identitymethod              = 'MyProxy'
      $gcs_security_keyfile                     = undef
      $gcs_security_trustedcertificatedirectory = undef
      $gcs_gridftp_datainterface                = undef
      $gcs_gridftp_incomingportrange            = undef
      $gcs_gridftp_outgoingportrange            = undef
      $gcs_gridftp_restrictpaths                = undef
      $gcs_gridftp_server                       = '%(HOSTNAME)s'
      $gcs_gridftp_serverbehindnat              = undef
      $gcs_gridftp_sharing                      = undef
      $gcs_gridftp_sharinggroupsallow           = undef
      $gcs_gridftp_sharinggroupsdeny            = undef
      $gcs_gridftp_sharingrestrictpaths         = undef
      $gcs_gridftp_sharingstatedir              = undef
      $gcs_gridftp_sharingusersallow            = undef
      $gcs_gridftp_sharingusersdeny             = undef
      $gcs_myproxy_cadirectory                  = undef
      $gcs_myproxy_configfile                   = undef
      $gcs_myproxy_server                       = '%(HOSTNAME)s'
      $gcs_myproxy_serverbehindnat              = undef
      $gcs_oauth_logo                           = undef
      $gcs_oauth_server                         = undef
      $gcs_oauth_serverbehindnat                = undef
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}