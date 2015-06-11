node 'controller' {
  include assets
  include ntp
  include openstack
  include mariadb
  include rabbitmq
}

node 'network' {
  include assets
  include ntp
}

node 'compute' {
  include assets
  include ntp
}
