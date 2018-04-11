#
# == Class: windows_wmf
#
# Base profile for windowses
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
class windows_wmf
{

  reboot { 'dsc_reboot':
    message => 'DSC has requested a reboot',
    when    => 'pending',
  }

  $dotnetkb = $::facts['os']['release']['full'] ? {
    '7'       => 'KB4033342',
    '8.1'     => 'KB4033369',
    '2008 R2' => 'KB4033342',
    '2012'    => 'KB4033345',
    '2012 R2' => 'KB4033369',
    '2016'    => 'KB4033369',
    default   => undef,
  }

  windows_updates::kb { '.NET 4.7.1':
    ensure   => 'present',
    kb       => $dotnetkb,
  }

  $wmf5kb = $::facts['os']['release']['full'] ? {
    '7'       => 'KB3134760',
    '8.1'     => 'KB3134758',
    '2008 R2' => 'KB3134760',
    '2012'    => 'KB3134759',
    '2012 R2' => 'KB3134758',
    default   => undef,
  }

  windows_updates::kb { 'WMF5.0':
    ensure   => 'present',
    kb       => $wmf5kb,
    require  => Windows_updates::Kb['.NET 4.7.1'],
  }
}


