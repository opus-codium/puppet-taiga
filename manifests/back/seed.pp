class taiga::back::seed {
  assert_private()

  taiga::back::manage { 'loaddata initial_user': }
  -> taiga::back::manage { 'loaddata initial_project_templates': }
}
