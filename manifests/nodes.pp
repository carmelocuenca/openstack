node 'controller' {
  include assets
  include ntp
}

node 'network' {
  include assets
  include ntp
}

node 'compute' {
  include assets
  include ntp
}
