class rabbitmq {
  $RABBIT_PASS = 'openstack'

  # Install the package
  package { 'rabbitmq-server':
    ensure => installed,
  }

  # Add the openstack user
  exec { 'rabbitmqctl add_user openstack':
    command => "/usr/sbin/rabbitmqctl add_user openstack ${RABBIT_PASS}",
    require => Package['rabbitmq-server']
  }

  # Permit configuration, write, and read accesss for the openstack user
  exec { 'rabbitmqctl set_permissions openstack':
    command => '/usr/sbin/rabbitmqctl set_permissions openstack ".*" ".*" ".*"',
    require => Exec['rabbitmqctl add_user openstack']
  }

}
