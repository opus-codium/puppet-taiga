# @summary Manage Taiga front config
#
# @api private
class taiga::front::config {
  assert_private()

  $login_form_type = $taiga::front::ldap_enable ? {
    true    => 'ldap',
    default => undef,
  }

  $ws_protocol = $taiga::front::back_protocol ? {
    'http'  => 'ws',
    'https' => 'wss',
  }

  file { "${taiga::front::install_dir}/dist/conf.json":
    ensure  => file,
    owner   => $taiga::front::user,
    mode    => '0644',
    content => epp('taiga/front/conf.json'),
  }
}
