#
# == Class: windows_wmf
#
# Install Windows Management Framework
#
# === Parameters
#
# None
#
# === Variables
#
# None
#
# === Examples
#
#  include windows_wmf
#
# === Authors
#
# Petri Lammi <petri.lammi@puppeteers.fi>
# Samuli Seppänen <samuli.seppanen@puppeteers.fi>
#
# === Copyright
#
# Copyright 2018 Petri Lammi, Samuli Seppänen
#
# Credits to red-gate, https://github.com/red-gate/puppet-wmf for working code and ideas
class windows_wmf(

  $wmf_version = $windows_wmf::params::version,
  $temp_folder = $windows_wmf::params::temp_folder,
  $dotnetkb    = $windows_wmf::params::dotnetkb,
  ) inherits windows_wmf::params
{

  windows_updates::kb { '.NET 4.7.1':
    ensure => 'present',
    kb     => $dotnetkb,
  }

  unless (versioncmp("${facts['powershell_version']}", '5') > 0 or versioncmp("${facts['powershell_version']}", '5') == 1 ) { 

    unless has_key($windows_wmf::params::urls, "${version}") {
      fail("This version of WMF is not supported: ${version}")
    }

    unless has_key($windows_wmf::params::urls["${version}"], $::operatingsystemrelease) {
      fail("This OS (${::operatingsystemrelease}) is not supported for WMF ${version}")
    }

    $download_url = $windows_wmf::params::urls["${version}"][$::operatingsystemrelease]
    $kb_number = $download_url.match(/(KB\d+)/)[1]

    file { $temp_folder:
      ensure => directory,
    }

    -> file { "${temp_folder}/wmf_${version}.msu":
      ensure => 'present',
      source => $download_url,
    }
    
    -> exec { "Install WMF ${version}":
      # Need to use "cmd.exe /c Start" to block the exec task until the wusa.exe exit.
      command  => "cmd.exe /c Start /WAIT wusa.exe \"${temp_folder}/wmf_${version}.msu\" /quiet /norestart",
      returns  => [0, 3010],
      unless   => "cmd.exe /c C:\\Windows\\System32\\wbem\\WMIC.exe qfe | findstr ${kb_number}",
      path     => 'C:/Windows/System32/',
      provider => 'windows',
    }
    
    ~> reboot { "Reboot after installation of WMF version ${version}": }
  }
}

