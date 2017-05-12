#
class druid::params {

  $version      = '0.10.0'
  $download_url = 'http://static.druid.io/artifacts/releases'

  $druid_group  = 'druid'
  $druid_user   = 'druid'
  $user_home    = '/opt/druid.io'

  $config_directory = '/etc/druid'
  $config_template  = 'druid/druid.properties.erb'
  $config_options   = {}

}
