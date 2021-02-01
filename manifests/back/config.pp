# @summary Configure Taiga back
#
# @api private
class taiga::back::config {
  assert_private()

  concat { "${taiga::back::install_dir}/settings/local.py":
    ensure    => present,
    owner     => $taiga::back::user,
    group     => 'nogroup',
    show_diff => false,
  }

  concat::fragment { 'taiga-back-local.py-base':
    target  => "${taiga::back::install_dir}/settings/local.py",
    content => epp('taiga/back/local.py'),
    order   => '00',
  }

  if $taiga::back::ldap_enable {
    concat::fragment { 'taiga-back-local.py-ldap':
      target  => "${taiga::back::install_dir}/settings/local.py",
      content => epp('taiga/back/local.py-ldap'),
      order   => '10',
    }
  }
}
