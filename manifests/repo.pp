# Install Globus yum repo
class globus::repo {

  include globus
  include globus::params

  $globus_repo_rpm  = $globus::params::globus_yumrepo_rpm
  $globus_gpg_key   = '/etc/pki/rpm-gpg/RPM-GPG-KEY-Globus'

  package { 'globus-toolkit-repo':
    ensure   => 'installed',
    source   => $globus_repo_rpm,
    provider => 'rpm',
  }

  file { $globus_gpg_key:
    ensure => present,
    source => 'puppet:///modules/globus/RPM-GPG-KEY-Globus',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  exec {  'import-globus-key':
    path    => '/bin:/usr/bin:/sbin:/usr/sbin',
    command => "rpm --import ${globus_gpg_key}",
    unless  => "rpm -q gpg-pubkey-$(echo $(gpg --throw-keyids < ${globus_gpg_key}) | cut --characters=11-18 | tr '[A-Z]' '[a-z]')",
    require => File[$globus_gpg_key],
  }

}