#
define druid::service (
  $jvm_config_template     = 'druid/jvm.config.erb',
  $jvm_config_options      = [],
  $runtime_config_template = 'druid/runtime.properties.erb',
  $runtime_config_options  = {},
  $service_template        = 'druid/druid.systemd.erb',
  $service_options         = {},
  $service_ensure          = 'running',
  $service_enable          = true,
) {

  # Validate service name
  if ! ($name in ['broker', 'coordinator', 'historical', 'middleManager', 'overlord']) {
    fail('Invalid daemon type')
  }

  include ::druid

  file { "/etc/druid/${name}":
    ensure => directory,
    owner  => $::druid::druid_user,
    group  => $::druid::druid_group,
    mode   => '0550',
  }

  file { "/etc/druid/${name}/jvm.config":
    ensure  => file,
    owner   => $::druid::druid_user,
    group   => $::druid::druid_group,
    mode    => '0440',
    content => template($jvm_config_template),
    notify  => Service["druid-${name}"],
  }

  file { "/etc/druid/${name}/runtime.properties":
    ensure  => file,
    owner   => $::druid::druid_user,
    group   => $::druid::druid_group,
    mode    => '0440',
    content => template($runtime_config_template),
    notify  => Service["druid-${name}"],
  }

  file { "/etc/systemd/system/druid-${name}.service":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_template),
    notify  => Service["druid-${name}"],
  }

  service { "druid-${name}":
    ensure    => $service_ensure,
    enable    => $service_enable,
    subscribe => File['/etc/druid/_common/common.runtime.properties'],
  }

}
