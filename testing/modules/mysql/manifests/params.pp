class mysql::params {
      $bind_address          = '127.0.0.1'
      $port                  = 3306
      $etc_root_password     = false
      $ssl                   = false
  case $operatingsystem {
      Solaris: {
        
        }
      /(Ubuntu|Debian)/: {

        }
      /(Redhat|CentOS|Fedora)/: {
      $basedir               = '/usr'
      $datadir               = '/var/lib/mysql'
      $service_name          = 'mysqld'
      $client_package_name   = 'mysql'
      $server_package_name   = 'mysql-server'
      $socket                = '/var/lib/mysql/mysql.sock'
      $pidfile               = '/var/run/mysqld/mysqld.pid'
      $config_file           = '/etc/my.cnf'
      $log_error             = '/var/log/mysqld.log'
#     $ruby_package_name     = 'ruby-mysql'
#     $ruby_package_provider = 'gem'
#     $python_package_name   = 'MySQL-python'
#     $java_package_name     = 'mysql-connector-java'
      $root_group            = 'root'
#     $ssl_ca                = '/etc/mysql/cacert.pem'
#     $ssl_cert              = '/etc/mysql/server-cert.pem'
#     $ssl_key               = '/etc/mysql/server-key.pem'
        }
  default: {
        }
     }
  }
