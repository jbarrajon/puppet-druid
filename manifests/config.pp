#
class druid::config inherits ::druid {

  if $::druid::manage_config {
    file { ['/etc/druid', '/etc/druid/_common']:
      ensure => directory,
      owner  => $::druid::druid_user,
      group  => $::druid::druid_group,
      mode   => '0550',
    }

    $runtime_config_options = $::druid::common_runtime_config_options

    file { '/etc/druid/_common/common.runtime.properties':
      ensure  => file,
      owner   => $::druid::druid_user,
      group   => $::druid::druid_group,
      mode    => '0440',
      content => template($::druid::common_runtime_config_template),
    }

    file { '/etc/druid/_common/log4j2.xml':
      ensure  => file,
      owner   => $::druid::druid_user,
      group   => $::druid::druid_group,
      mode    => '0440',
      content => template($::druid::log4j_config_template),
    }
  }

}
