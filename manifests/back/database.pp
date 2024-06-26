# @summary Configure Taiga back database
#
# @api private
class taiga::back::database {
  assert_private()

  include postgresql::server

  postgresql::server::db { $taiga::back::db_name:
    user     => $taiga::back::db_user,
    owner    => $taiga::back::db_user,
    password => postgresql::postgresql_password($taiga::back::db_user, $taiga::back::db_password),
  }
}
