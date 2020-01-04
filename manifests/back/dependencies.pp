# @summary Configure Taiga back dependencies
#
# @api private
class taiga::back::dependencies {
  assert_private()

  ensure_packages($taiga::back::dependencies, {
    ensure => installed,
  })
}
