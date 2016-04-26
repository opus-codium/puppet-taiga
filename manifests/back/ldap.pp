class taiga::back::ldap {
  include taiga::back

  exec { 'taiga_contrib_ldap_auth-deploy':
    # command => "${taiga_contrib_ldap_auth::back_directory}/bin/pip install git+https://github.com/ensky/taiga-contrib-ldap-auth.git",
    command => "${taiga::back::install_dir}/bin/pip install git+https://github.com/flyingcircle/taiga-contrib-ldap-auth.git@patch-1",
    user    => $taiga::back::user,
    creates => "${taiga::back::install_dir}/lib/python3.4/site-packages/taiga_contrib_ldap_auth",
  }
}
