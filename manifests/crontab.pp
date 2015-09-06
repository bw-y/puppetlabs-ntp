#
class ntp::crontab {

  if ( $::ntp::service_ensure == 'running' and $::ntp::ntpdate_cron == 'present' ) {
    #fail('ntp service_ensure must be stopped')
    notify { '--> Warning <--':
      message => "$::ntp::params::service_name ensure must be stopped"
    }
  }

  $cron_servers = join($::ntp::servers, " ")

  cron { 'crontab_ntpdate':
    command => "${::ntpdate_cmd} $cron_servers && ${::hwclock_cmd} -w > /dev/null 2>&1",
    ensure  => $::ntp::ntpdate_cron,
    user    => root,
    minute  => '30',
  } 
  
}
