#
class druid (
  $version       = $::druid::params::version,
  $download_url  = $::druid::params::download_url,
  $manage_group  = $::druid::params::manage_group,
  $druid_group   = $::druid::params::druid_group,
  $manage_user   = $::druid::params::manage_user,
  $druid_user    = $::druid::params::druid_user,
  $manage_home   = $::druid::params::manage_home,
  $user_home     = $::druid::params::user_home,
  $manage_config = $::druid::params::manage_config,
  $common_runtime_config_template = $::druid::params::common_runtime_config_template,
  $common_runtime_config_options  = $::druid::params::common_runtime_config_options,
  $log4j_config_template = $::druid::params::log4j_config_template,
  $log4j_config_options  = $::druid::params::log4j_config_options,
) inherits ::druid::params {

  include ::druid::install
  include ::druid::config

  Class['::druid::install'] -> Class['::druid::config']

}
