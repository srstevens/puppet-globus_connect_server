# Install Globus yum repo
class globus::repo {

  include globus
  include globus::params

  $globus_repo_rpm  = $globus::params::globus_yumrepo_rpm

  package { 'globus-toolkit-repo':
    ensure   => 'installed',
    source   => $globus_repo_rpm,
    provider => 'rpm',
  }

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-Globus':
    ensure => present,
    source => 'puppet:///modules/globus/RPM-GPG-KEY-Globus',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  exec {  'import-globus-key':
    path    => '/bin:/usr/bin:/sbin:/usr/sbin',
    command => 'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-Globus',
    unless  => "rpm -q gpg-pubkey-$(echo $(gpg --throw-keyids < ${path}) | cut --characters=11-18 | tr '[A-Z]' '[a-z]')",
    require => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-Globus'],
  }

}