class mysql::config(
   $bind_address      = $mysql::params::bind_address,
   $port              = $mysql::params::port,
   $service_name      = $mysql::params::service_name,
   $config_file       = $mysql::params::config_file,
   $pidfile           = $mysql::params::pidfile,
   $datadir           = $mysql::params::datadir,
   $socket            = $mysql::params::socket,
   $log_error         = $mysql::params::log_error,
   $default_engine    = 'UNSET',
#  $root_password     = 'UNSET',
#  $old_root_password = '',
#  $etc_root_password = $mysql::params::etc_root_password,
#  $ssl               = $mysql::params::ssl,
#  $ssl_ca            = $mysql::params::ssl_ca,
#  $ssl_cert          = $mysql::params::ssl_cert,
#  $ssl_key           = $mysql::params::ssl_key,
  $root_group        = $mysql::params::root_group
) inherits mysql::params {

  File {
    owner  => 'root',
    group  => $root_group,
    mode   => '0400',
    notify => Exec['mysqld-restart'],
  }

#  if $ssl and $ssl_ca == undef {
#    fail('The ssl_ca parameter is required when ssl is true')
#  }
#
#  if $ssl and $ssl_cert == undef {
#    fail('The ssl_cert parameter is required when ssl is true')
#  }
#
#  if $ssl and $ssl_key == undef {
#    fail('The ssl_key parameter is required when ssl is true')
#  }

  # This kind of sucks, that I have to specify a difference resource for
  # restart.  the reason is that I need the service to be started before mods
  # to the config file which can cause a refresh
  exec { 'mysqld-restart':
    command     => "service ${service_name} restart",
    logoutput   => on_failure,
    refreshonly => true,
    path        => '/sbin/:/usr/sbin/:/usr/bin/:/bin/',
  }

  # manage root password if it is set
#  if $root_password != 'UNSET' {
#    case $old_root_password {
#      '':      { $old_pw='' }
#      default: { $old_pw="-p'${old_root_password}'" }
#    }

#    exec { 'set_mysql_rootpw':
#      command   => "mysqladmin -u root ${old_pw} password '${root_password}'",
#      logoutput => true,
#      unless    => "mysqladmin -u root -p'${root_password}' status > /dev/null",
#      path      => '/usr/local/sbin:/usr/bin:/usr/local/bin',
#      notify    => Exec['mysqld-restart'],
#      require   => File['/etc/mysql/conf.d'],
#    }

#    file { '/root/.my.cnf':
#      content => template('mysql/my.cnf.pass.erb'),
#      require => Exec['set_mysql_rootpw'],
#    }

#    if $etc_root_password {
#      file{ '/etc/my.cnf':
#        content => template('mysql/my.cnf.pass.erb'),
#        require => Exec['set_mysql_rootpw'],
#      }
#    }
#  }
#
#  file { '/etc/mysql':
#    ensure => directory,
#    mode   => '0755',
#  }
  file { '/etc/mysql/conf.d':
    ensure => directory,
    mode   => '0755',
  }
  file { $config_file:
    content => template('mysql/my.cnf.erb'),
    mode    => '0644',
  }

}
#    file {"/etc/my.cnf":
#       ensure => present,
#       source => "puppet:///modules/mysql/my.cnf",
#       owner  => "mysql",
#       group  => "mysql",
#       require => Class["mysql::install"],
#       notify  => Class["mysql::service"],
#    }
#    file {"/var/lib/mysql":
#       group => "mysql",
#       owner => "mysql",
#       recurse => true,
#       require => File["/etc/my.cnf"],
#    }
#}
