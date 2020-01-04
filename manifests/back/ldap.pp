# @summary Manage Taiga back LDAP configuration
#
# @api private
class taiga::back::ldap {
  assert_private()

  exec { 'taiga_contrib_ldap_auth-deploy':
    command => "${taiga::back::install_dir}/bin/pip install git+https://github.com/ensky/taiga-contrib-ldap-auth.git",
    user    => $taiga::back::user,
    creates => "${taiga::back::install_dir}/lib/python${taiga::back::python_version}/site-packages/taiga_contrib_ldap_auth",
  }
}
