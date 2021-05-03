# @summary Install Taiga back
#
# @api private
class taiga::back::install {
  assert_private()

  python::pyvenv { $taiga::back::venv_dir:
    ensure     => present,
    systempkgs => false,
    owner      => $taiga::back::user,
    group      => $taiga::back::user,
  }

  python::requirements { "${$taiga::back::install_dir}/requirements.txt":
    virtualenv => $taiga::back::venv_dir,
    owner      => $taiga::back::user,
    group      => $taiga::back::user,
  }
}
