class mariadb {
  package {'python-mysqldb':
    ensure => installed,
  }

  exec { 'debconf-set-selections':
    command =>
      '/bin/echo mariadb-server-5.5	mysql-server/root_password	password openstack \
      | debconf-set-selections \
      && /bin/echo mariadb-server-5.5 mysql-server/root_password_again password openstack \
      | debconf-set-selections'
  }

  package {'mariadb-server-5.5':
    ensure => installed,
    require => Exec['debconf-set-selections']
  }

  service { 'mysql':
    ensure => running,
    enable => true,
    require => Package['mariadb-server-5.5']
  }

  file {'/etc/mysql/conf.d/mysqld_openstack.cnf':
    content => template('mariadb/etc/mysql/conf.d/mysqld_openstack.cnf.erb'),
    require => Package['mariadb-server-5.5'],
    notify => Service['mysql']
  }

  # Enter current password for root (enter for none):
  # Change the root password? [Y/n]
  # Remove anonymous users? [Y/n]
  # Disallow root login remotely? [Y/n]
  # Remove test database and access to it? [Y/n]
  # Reload privilege tables now? [Y/n]
  exec { 'mysql_secure_installation':
    command => '/usr/bin/printf "openstack\nn\nY\nY\nY\nY\n" | /usr/bin/mysql_secure_installation',
    require => [Service['mysql'], File['/etc/mysql/conf.d/mysqld_openstack.cnf']]
  }
}