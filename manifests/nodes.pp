node 'controller' {
  include assets
  include ntp
  include openstack
}

node 'network' {
  include assets
  include ntp
}

node 'compute' {
  include assets
  include ntp
}
