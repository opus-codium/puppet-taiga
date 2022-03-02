#!/bin/sh

set -ex

request () {
  echo "$1" | sudo -u postgres psql "${PT_database}"
}

echo "Active users:"
request "SELECT full_name, username, email, last_login FROM users_user WHERE is_active='t';"

echo "Inactive users:"
request "SELECT full_name, username, email, last_login FROM users_user WHERE is_active='f';"
