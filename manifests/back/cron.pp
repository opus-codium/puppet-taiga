# @summary Setup crontab
#
# @api private
class taiga::back::cron {
  if $taiga::back::change_notification_min_interval and $taiga::back::change_notification_min_interval > 0 {
    $ensure = 'present'
  } else {
    $ensure = 'absent'
  }

  cron { 'taiga-send-notifications':
    ensure  => $ensure,
    command => "cd ${taiga::back::install_dir} && ${taiga::back::install_dir}/bin/python manage.py send_notifications 2> /dev/null",
    user    => $taiga::back::user,
    hour    => '*',
    minute  => '*/10',
  }
}
