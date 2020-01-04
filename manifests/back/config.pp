# @summary Configure Taiga back
#
# @api private
class taiga::back::config {
  assert_private()

  concat { "${taiga::back::install_dir}/settings/local.py":
    ensure => present,
    owner  => $taiga::back::user,
    group  => 'nogroup',
  }

  concat::fragment { 'taiga-back-local.py-base':
    target  => "${taiga::back::install_dir}/settings/local.py",
    content => template('taiga/back/local.py.erb'),
    order   => '00',
  }

  if $taiga::back::ldap_enable {
    concat::fragment { 'taiga-back-local.py-ldap':
      target  => "${taiga::back::install_dir}/settings/local.py",
      content => template('taiga/back/local.py-ldap.erb'),
      order   => '10',
    }
  }
}
