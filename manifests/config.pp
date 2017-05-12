#
class druid::config inherits ::druid {

  file { $::druid::config_directory :
    ensure => directory,
    owner  => $::druid::druid_user,
    group  => $::druid::druid_group,
  }

  file { "${::druid::config_directory}/common.runtime.properties":
    ensure  => file,
    content => template($::druid::config_template),
  }

}
