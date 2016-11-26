class taiga::back::seed {
  ::taiga::back::manage { 'loaddata initial_user': } ->
  ::taiga::back::manage { 'loaddata initial_project_templates': } ->
  ::taiga::back::manage { 'loaddata initial_role': }
}
