class taiga::back::database {
  assert_private()

  include postgresql::server

  postgresql::server::db { $taiga::back::db_name:
    user     => $taiga::back::db_user,
    password => postgresql_password($taiga::back::db_user, $taiga::back::db_password),
  }
}
