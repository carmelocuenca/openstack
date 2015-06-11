node 'base' {
  include assets
  include ntp
}

node 'controller' inherits 'base' {
  include openstack
  include mariadb
  include rabbitmq
}

node 'network' inherits 'base' {
}

node 'compute' inherits 'base' {
}
