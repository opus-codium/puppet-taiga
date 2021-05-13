# @summary Configure Taiga back dependencies
#
# @api private
class taiga::back::dependencies {
  assert_private()

  include python

  ensure_packages($taiga::back::dependencies, { ensure => installed, })
}
