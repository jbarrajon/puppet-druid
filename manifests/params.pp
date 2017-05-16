#
class druid::params {

  $version      = '0.10.0'
  $download_url = 'http://static.druid.io/artifacts/releases'

  $manage_group = true
  $druid_group  = 'druid'
  $manage_user  = true
  $druid_user   = 'druid'
  $manage_home  = true
  $user_home    = '/opt/druid.io'

  $manage_config = true
  $common_runtime_config_template  = 'druid/runtime.properties.erb'
  $common_runtime_config_options   = {}
  $log4j_config_template = 'druid/log4j2.xml.erb'
  $log4j_config_options  = {}

}
