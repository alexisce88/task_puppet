class forward_proxy {
  package { 'nginx':
    ensure => 'installed',
  }

  service { 'nginx':
    ensure => 'running',
    enable => true,
  }

  file { '/etc/nginx/conf.d/forward_proxy.conf':
    ensure  => 'file',
    content => template('forward_proxy/forward_proxy.conf.erb'),
    notify  => Service['nginx'],
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/conf.d/health_check.conf':
    ensure  => 'file',
    content => template('forward_proxy/health_check.conf.erb'),
    notify  => Service['nginx'],
    require => Package['nginx'],
  }
}