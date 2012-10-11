#
# nagios module
# nagios.pp - everything nagios related
#
# Copyright (C) 2007 David Schmitt <david@schmitt.edv-bus.at>
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class nagios {

	$nagios_allow_external_cmd=true

	#this was originally included in site.pp
	include nagios::defaults

	user { nagios:
	ensure => present
	}

	group { nagios:
	ensure => present,
	require => User['nagios']
	}

    case $nagios_httpd {
        'absent': { }
        'lighttpd': { include lighttpd }
        'apache': { include apache }
        default: { include apache }
    }
    case $::osfamily {
        'redhat': {
            $nagios_cfgdir = '/etc/nagios'
            include nagios::redhat
        }
        'debian': {
            $nagios_cfgdir = '/etc/nagios3'
            include nagios::debian
        }
        default: { fail("No such osfamily: ${::osfamily} yet defined") }
    }

        @@host {nagiosserver1:
                ensure => present,
                name => nagiosserver1,
                ip => $::ipaddress
                }

        #room for enhancement here.  it's just a dup of nagiosserver1.
        @@host {nagiosserver2:
                ensure => present,
                name => nagiosserver2,
                ip => $::ipaddress
                }

}
