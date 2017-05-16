#
class druid::install inherits ::druid {

  if $::druid::manage_group {
    group { $::druid::druid_group :
      ensure => present,
    }
  }

  if $::druid::manage_user {
    user { $::druid::druid_user :
      ensure     => present,
      comment    => 'Druid User',
      gid        => $::druid::druid_group,
      home       => $::druid::user_home,
      managehome => $::druid::manage_home,
      system     => true,
    }
  }

  archive { "druid-${::druid::version}-bin.tar.gz":
    path         => "${::druid::user_home}/druid-${::druid::version}-bin.tar.gz",
    source       => "${::druid::download_url}/druid-${::druid::version}-bin.tar.gz",
    extract      => true,
    extract_path => $::druid::user_home,
    creates      => "${::druid::user_home}/druid-${::druid::version}",
    user         => $::druid::druid_user,
    group        => $::druid::druid_group,
    cleanup      => false,
  }

  file { "${::druid::user_home}/druid-${::druid::version}":
    ensure  => directory,
    owner   => $::druid::druid_user,
    group   => $::druid::druid_group,
    require => Archive["druid-${::druid::version}-bin.tar.gz"],
  }

  file { "${::druid::user_home}/druid":
    ensure => 'link',
    target => "${::druid::user_home}/druid-${::druid::version}",
  }

  file { '/var/log/druid':
    ensure => directory,
    owner  => $::druid::druid_user,
    group  => $::druid::druid_group,
    mode   => '0755',
  }

  file { '/var/run/druid':
    ensure => directory,
    owner  => $::druid::druid_user,
    group  => $::druid::druid_group,
    mode   => '0755',
  }

}
