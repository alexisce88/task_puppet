class redirect_proxy {
  package { 'nginx':
    ensure => 'installed',
  }

  service { 'nginx':
    ensure => 'running',
    enable => true,
  }

  file { '/etc/nginx/sites-available/redirect_proxy':
    ensure  => 'file',
    content => template('redirect_proxy/nginx_config.erb'),
    notify  => Service['nginx'],
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-enabled/redirect_proxy':
    ensure => 'link',
    target => '/etc/nginx/sites-available/redirect_proxy',
    notify => Service['nginx'],
    require => Package['nginx'],
  }

  File['/etc/nginx/sites-enabled/default'] -> File['/etc/nginx/sites-available/redirect_proxy']
}
