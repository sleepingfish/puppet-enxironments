class nagios::defaults::hostgroups {

 nagios_hostgroup {
    'all':
      alias   => 'All Servers',
    	members => '*';
    'debian-servers':
      alias   => 'Debian GNU/Linux Servers';
    'redhat-servers':
      alias   => 'RedHat GNU/Linux Servers';

    #not for nagios2.  can be used for nagios3.
    'linux-servers':
      alias => 'Linux Servers',
      hostgroup_members => 'redhat-servers,debian-servers';


	}
	}

