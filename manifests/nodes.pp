node 'base' {
  include assets
  include ntp
}

node 'controller' inherits 'base' {
  include openstack
  include mariadb
  include rabbitmq
  include keystone
}

node 'network' inherits 'base' {
}

node 'compute' inherits 'base' {
}
