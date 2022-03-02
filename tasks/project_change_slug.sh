#!/bin/sh

set -ex

cd "${PT_backend_directory}"
"${PT_venv_directory}/bin/python" manage.py change_project_slug "${PT_current_slug}" "${PT_new_slug}"
