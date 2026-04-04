# This Puppet manifest configures Nginx and system parameters to handle high concurrent requests in WSL

# Increase the system-wide maximum connection queue
exec { 'increase-somaxconn':
  command => 'sysctl -w net.core.somaxconn=1024',
  path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
}

# Configure Nginx worker connections for high concurrency
exec { 'configure-nginx-workers':
  command => 'sed -i "/worker_connections/c\    worker_connections 1024;" /etc/nginx/nginx.conf',
  path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  require => Exec['increase-somaxconn'],
}

# Start Nginx or reload if already running
exec { 'start-or-reload-nginx':
  command => '[ -f /run/nginx.pid ] && /usr/sbin/nginx -s reload || /usr/sbin/nginx',
  path    => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  require => Exec['configure-nginx-workers'],
}