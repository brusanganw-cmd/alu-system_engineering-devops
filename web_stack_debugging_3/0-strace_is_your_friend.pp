# This Puppet manifest fixes WordPress file permissions so Apache can serve files without 500 errors
file { '/var/www/html':
  ensure  => directory,
  recurse => true,
  owner   => 'www-data',
  group   => 'www-data',
  mode    => '0755',
}