# Default parameter values
class globus_connect_server::params {

  case $::osfamily {
    'RedHat': {
      $globus_yumrepo_rpm = 'https://downloads.globus.org/toolkit/globus-connect-server/globus-connect-server-repo-latest.noarch.rpm'
      $globus_connect_server_package = 'globus-connect-server'
      $globus_connect_server_conf = '/etc/globus-connect-server.conf'
      $globus_connect_gridftp_conf = '/etc/gridftp.conf'
      $globus_connect_gridftp_gfork = '/etc/gridftp.gfork'

      $gridftp_service_name = 'globus-gridftp-server'
      $gridftp_server_log_conf = '/var/lib/globus-connect-server/gridftp.d/globus-connect-server-gridftp-logging'
      $gridftp_server_log = '/var/log/gridftp.log'
      $gridftp_log_level = 'ERROR,WARN'
      $myproxy_server_log = undef

      # variable format: section_parameter. e.g.
      #   [Globus]
      #   User
      # is $globus_user
      $gcs_globus_user                          = undef
      $gcs_globus_password                      = undef
      $gcs_use_env_credentials                  = true
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
      $gcs_gridftp_incomingportrange            = '50000-51000'
      $gcs_gridftp_outgoingportrange            = '50000-51000'
      $gsc_gridftp_control_channel_port         = 2811
      $gcs_gridftp_restrictpaths                = []
      $gcs_gridftp_server                       = '%(HOSTNAME)s'
      $gcs_gridftp_serverbehindnat              = undef
      $gcs_gridftp_sharing                      = undef
      $gcs_gridftp_sharinggroupsallow           = []
      $gcs_gridftp_sharinggroupsdeny            = []
      $gcs_gridftp_sharingrestrictpaths         = undef
      $gcs_gridftp_sharingstatedir              = undef
      $gcs_gridftp_sharingusersallow            = []
      $gcs_gridftp_sharingusersdeny             = []
      $gcs_myproxy_cadirectory                  = undef
      $gcs_myproxy_configfile                   = undef
      $gcs_myproxy_server                       = undef
      $gcs_myproxy_port                         = 7512
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
