# @summary Install Taiga back
#
# @api private
class taiga::back::install {
  assert_private()

  if fact('os.family') == 'debian' {
    stdlib::ensure_packages('python3-wheel', { ensure => installed })
  }

  if $python::dev != 'present' {
    fail("Python developement tools must be installed.  Set \$python::dev to 'present'.")
  }

  python::pyvenv { $taiga::back::venv_dir:
    ensure     => present,
    systempkgs => true,
    owner      => $taiga::back::user,
    group      => $taiga::back::user,
  }

  # XXX: Recent version of setuptools (installed by puppet-python) does not bundle pycparser anymore, which cause trouble with dependencies
  # https://github.com/pypa/setuptools/issues/580
  -> exec { 'fix-setuptools-pycparser':
    command => "${taiga::back::venv_dir}/bin/pip install pycparser",
    creates => "${taiga::back::venv_dir}/lib/python${facts['python3_release']}/site-packages/pycparser",
  }

  -> python::requirements { "${$taiga::back::install_dir}/requirements.txt":
    virtualenv => $taiga::back::venv_dir,
    owner      => $taiga::back::user,
    group      => $taiga::back::user,
  }
}
