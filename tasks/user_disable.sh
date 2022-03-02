#!/bin/sh

set -ex

request () {
  echo "$1" | sudo -u postgres psql "${PT_database}"
}

request "UPDATE users_user SET is_active='f' WHERE username='${PT_username}';"
