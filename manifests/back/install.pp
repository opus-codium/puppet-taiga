# @summary Install Taiga back
#
# @api private
class taiga::back::install {
  assert_private()

  if fact('os.family') == 'debian' {
    ensure_packages('python3-wheel', { ensure => installed })
  }

  python::pyvenv { $taiga::back::venv_dir:
    ensure     => present,
    systempkgs => true,
    owner      => $taiga::back::user,
    group      => $taiga::back::user,
  }

  python::requirements { "${$taiga::back::install_dir}/requirements.txt":
    virtualenv => $taiga::back::venv_dir,
    owner      => $taiga::back::user,
    group      => $taiga::back::user,
  }
}
