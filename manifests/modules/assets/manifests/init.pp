class assets {
  file { '/etc/hosts':
    source => 'puppet:///modules/assets/etc/hosts'
  }
}
