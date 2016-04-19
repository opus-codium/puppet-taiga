class taiga::back::database {
  include taiga::back

  postgresql::server::db { $taiga::back::db_name:
    user     => $taiga::back::db_user,
    password => postgresql_password($taiga::back::db_user, $taiga::back::db_password),
  }
}
