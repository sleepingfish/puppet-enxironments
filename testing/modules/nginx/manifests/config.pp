class nginx::config {
     file { "/etc/nginx/nginx.conf":
        ensure => present,
        source => "puppet:///modules/nginx/nginx.conf",
        owner  => "nginx",
        group  => "nginx",
        require => Class["nginx::install"],
        notify  => Class["nginx::service"],
    }
}
