node 'controller' {
  include assets
  include ntp
  include openstack
  include mariadb
}

node 'network' {
  include assets
  include ntp
}

node 'compute' {
  include assets
  include ntp
}
