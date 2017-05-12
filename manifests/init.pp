#
class druid (
  $version          = $::druid::params::version,
  $download_url     = $::druid::params::download_url,
  $druid_group      = $::druid::params::druid_group,
  $druid_user       = $::druid::params::druid_user,
  $user_home        = $::druid::params::user_home,
  $config_directory = $::druid::params::config_directory,
  $config_template  = $::druid::params::config_template,
  $config_options   = $::druid::params::config_options,
) inherits ::druid::params {

  $release_archive = "druid-${version}-bin.tar.gz"
  $release_directory = "${user_home}/druid-${version}"

  include ::druid::install
  include ::druid::config

  Class['::druid::install'] -> Class['::druid::config']

}
