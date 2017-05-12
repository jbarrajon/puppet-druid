#
class druid::install inherits ::druid {

  group { $::druid::druid_group :
    ensure => present,
  }

  user { $::druid::druid_user :
    ensure     => present,
    comment    => 'Druid User',
    gid        => $::druid::druid_group,
    home       => $::druid::user_home,
    managehome => true,
    system     => true,
  }

  archive { $::druid::release_archive :
    path         => "${::druid::user_home}/${::druid::release_archive}",
    source       => "${::druid::download_url}/${::druid::release_archive}",
    extract      => true,
    extract_path => $::druid::user_home,
    creates      => $::druid::release_directory,
    user         => $::druid::druid_user,
    group        => $::druid::druid_group,
    cleanup      => false,
  }

  file { $::druid::release_directory :
    ensure  => directory,
    owner   => $::druid::druid_user,
    group   => $::druid::druid_group,
    require => Archive[$::druid::release_archive],
  }

  file { "${::druid::user_home}/druid":
    ensure => 'link',
    target => $::druid::release_directory,
  }

}
