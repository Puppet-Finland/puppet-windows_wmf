# profile_winbase

A Puppet module for managing basic settings on Windows(es)

# Usage

include profile_winbase

# hiera

---
profile_winbase::manage_snmp: true
profile_winbase::snmp_community_string: opennms
profile_winbase::snmp_permitted_managers: 127.0.0.1
profile_winbase::snmp_syscontact: hostmaster@example.com
profile_winbase::snmp_syslocation: 'Somewhere but known'
profile_winbase::firewall_prefix: MYCOMPANY
profile_winbase::snmp_fwrules:
  'CUSTOM 161 ALLOW SNMP':
    dsc_name: 'CUSTOM ALLOW SNMP'
    dsc_displayname: 'CUSTOM ALLOW SNMP'
    dsc_enabled: 'True'
    dsc_action: 'Allow'
    dsc_profile:
      - 'Domain'
      - 'Private'
    dsc_direction: 'Inbound'
    dsc_remoteaddress:
      - '10.0.102.251'
    dsc_localport:
      - '161'
    dsc_protocol: 'UDP'
    dsc_description: 'CUSTOM Allow SNMP in'
    dsc_program: '%SystemRoot%\system32\snmp.exe'
    dsc_service: 'SNMP'
profile_winbase::puppetmaster_hostname: puppet.example.com
profile_winbase::puppetmaster_ip: 127.0.0.1
