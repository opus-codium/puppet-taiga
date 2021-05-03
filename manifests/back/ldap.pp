# @summary Manage Taiga back LDAP configuration
#
# @api private
class taiga::back::ldap {
  assert_private()

  exec { 'taiga_contrib_ldap_auth-deploy':
    command => "${taiga::back::venv_dir}/bin/pip install git+https://github.com/ensky/taiga-contrib-ldap-auth.git",
    user    => $taiga::back::user,
    creates => "${taiga::back::venv_dir}/lib/python${facts['python3_release']}/site-packages/taiga_contrib_ldap_auth",
  }
}
