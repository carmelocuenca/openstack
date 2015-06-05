class openstack {
  package {'ubuntu-cloud-keyring':
    ensure => installed
  }

  file { '/etc/apt/sources.list.d/cloudarchive-kilo.list':
    content => "deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main"
  }

  exec { "apt-get update":
    command => "/usr/bin/apt-get update",
    require => [Package['ubuntu-cloud-keyring'], File['/etc/apt/sources.list.d/cloudarchive-kilo.list']]
  }

  exec { "apt-get dist upgrade":
    command => "/usr/bin/apt-get -y dist-upgrade",
    require => Exec["apt-get update"]
  }
}
