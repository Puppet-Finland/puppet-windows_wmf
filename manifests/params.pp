#
# == Class: windows_wmf::params
#
# Parameters for windows_wmf module
class windows_wmf::params {
  $version = '5.0'
  $temp_folder = 'c:\\windows\\temp'
  $urls = {
    '5.0' => {
      '2012' => 'https://download.microsoft.com/download/2/C/6/2C6E1B4A-EBE5-48A6-B225-2D2058A9CEFB/W2K12-KB3134759-x64.msu',
      '2012 R2' => 'https://download.microsoft.com/download/2/C/6/2C6E1B4A-EBE5-48A6-B225-2D2058A9CEFB/Win8.1AndW2K12R2-KB3134758-x64.msu',
    },
    '5.1' => {
      '7'       => 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win7AndW2K8R2-KB3191566-x64.zip',
      '8.1'     => 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu',
      '2008 R2' => 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win7AndW2K8R2-KB3191566-x64.zip',
      '2012'    => 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/W2K12-KB3191565-x64.msu',
      '2012 R2' => 'https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win8.1AndW2K12R2-KB3191564-x64.msu',
    }
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
}
