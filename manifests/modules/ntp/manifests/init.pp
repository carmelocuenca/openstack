class ntp {
  package {'ntp':
    ensure => installed,
  }

  service {'ntp':
    ensure => running,
    require => Package['ntp']
  }

  $server = "ntp.ulpgc.es"
  file {'/etc/ntp.conf':
    content => template('ntp/etc/ntp.conf.erb'),
    require => Package['ntp'],
    notify => Service['ntp']
  }
}
