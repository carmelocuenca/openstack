class keystone {
  include mariadb

  $KEYSTONE_DBPASS='openstack'
  $ADMIN_TOKEN = '18ac2cf12a8b27694bfb' # openssl rand -hex 10

  # To avoid port conflicts, disable the keystone service from starting
  # automatically after installation.
  file { '/etc/init/keystone.override':
    content => "manual"
  }

  # Install packages
  $packages = ['keystone', 'python-openstackclient', 'apache2',
    'libapache2-mod-wsgi', 'memcached', 'python-memcache']

  package { $packages:
    ensure => installed,
    require => [File['/etc/init/keystone.override']]
  }

  # Create the keystone database
  exec { 'CREATE DATABASE':
    command => "/usr/bin/mysql -uroot -p${mariadb::MARIADB_ROOT_PASS} -e \
      'CREATE DATABASE IF NOT EXISTS keystone;'",
    require => Package[$packages],
  }

  # Grant proper acces to the keystone database
  exec { 'GRANT ALL PRIVILEGES ON':
    command => "/usr/bin/mysql -uroot -p${mariadb::MARIADB_ROOT_PASS} -e \
      \"GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost'     \
      IDENTIFIED BY  \'$KEYSTONE_DBPASS\';\"                             \
      && /usr/bin/mysql -uroot -p${mariadb::MARIADB_ROOT_PASS} -e        \
        \"GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%'           \
        IDENTIFIED BY \'$KEYSTONE_DBPASS\';\" ",
    require => Exec['CREATE DATABASE']
  }

  # Define the value of the initial administration token
  # Configure database access
  # Configure Memcache service
  # Configure the UUID token provider and Memcached driver
  # Configure the SQL revocation driver
  file {'/etc/keystone/keystone.conf':
    content => template('keystone/etc/keystone/keystone.conf.erb'),
    require => Package[$packages]
  }

  exec { 'keystone-manage db_sync':
    command => '/usr/bin/keystone-manage db_sync',
    require => [File['/etc/keystone/keystone.conf'], Exec['GRANT ALL PRIVILEGES ON']]
  }


}
