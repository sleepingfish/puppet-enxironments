class nginx::install {
   package { "nginx":
     ensure => installed,
     require => User["nginx"],
    }
   user { "nginx":
     ensure => present,
#     comment => "MySQL user",
     gid => "mysql",
     require => Group["nginx"],
    }
   group { "nginx":
     ensure => present,
    }
}
    
