#
define druid::extension (
  $extension_name = $name,
) {

  include ::druid

  archive { "${extension_name}-${::druid::version}.tar.gz":
    path         => "${::druid::user_home}/${extension_name}-${::druid::version}.tar.gz",
    source       => "${::druid::download_url}/${extension_name}-${::druid::version}.tar.gz",
    extract      => true,
    extract_path => "${::druid::user_home}/druid-${::druid::version}/extensions",
    creates      => "${::druid::user_home}/druid-${::druid::version}/extensions/${extension_name}",
    user         => $::druid::druid_user,
    group        => $::druid::druid_group,
    cleanup      => false,
  }

}
