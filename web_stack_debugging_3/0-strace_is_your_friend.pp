file { '/var/www/html':
  ensure  => directory,
  recurse => true,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
}