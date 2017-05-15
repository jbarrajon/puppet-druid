#
define druid::service (
  $config_template  = 'druid/druid.properties.erb',
  $config_options   = {},
  $service_template = 'druid/druid.systemd.erb',
  $service_options  = {},
  $service_ensure   = 'running',
  $service_enable   = true,
) {

  include ::druid

  file { "${::druid::config_directory}/${name}":
    ensure => directory,
  }

  file { "${::druid::config_directory}/${name}/runtime.properties":
    ensure  => file,
    content => template($config_template),
  }

  file { "${::druid::config_directory}/${name}/common.runtime.properties":
    ensure => link,
    target => "${::druid::config_directory}/common.runtime.properties",
  }

  file { "/etc/systemd/system/druid-${name}.service":
    ensure  => file,
    content => template($service_template),
    notify  => Exec["Reload systemd daemon for new ${name} service file"],
  }

  exec { "Reload systemd daemon for new ${name} service file":
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  }

  service { "druid-${name}":
    ensure    => $service_ensure,
    enable    => $service_enable,
    provider  => 'systemd',
    require   => File["/etc/systemd/system/druid-${name}.service"],
    subscribe => [
      Exec["Reload systemd daemon for new ${name} service file"],
      File["${::druid::config_directory}/${name}/runtime.properties"],
      File["${::druid::config_directory}/common.runtime.properties"],
    ],
  }

}
