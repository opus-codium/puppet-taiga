class taiga::back::migrate {
  taiga::back::manage { 'migrate --noinput': } ->
  taiga::back::manage { 'compilemessages': } ->
  taiga::back::manage { 'collectstatic --noinput': }
}
