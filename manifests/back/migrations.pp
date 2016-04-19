class taiga::back::migrations {
  taiga::back::migration {
  'migrate --noinput':;
  'loaddata initial_user':;
  'loaddata initial_project_templates':;
  'loaddata initial_role':;
  'compilemessages':;
  'collectstatic --noinput':;
  }
}
