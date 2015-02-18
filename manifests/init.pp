
class environment(
  $modules_mange          = false,
  $modules                = undef,
  $modules_modulepath     = 'DEFAULT',
  $modules_package        = 'DEFAULT',
  $modules_conf_sh        = 'DEFAULT',
  $modules_conf_csh       = 'DEFAULT',
  $alias_manage           = false,
  $alias                  = undef,
  $alias_conf_sh          = 'DEFAULT',
  $alias_conf_csh         = 'DEFAULT',
  $environment_manage     = false,
  $environment            = undef,
  $environment_conf_sh    = 'DEFAULT',
  $environment_conf_csh   = 'DEFAULT',

) {

  $manage_alias_real = $manage_alias

  ## < OS Defaults >

  case $::osfamily {
    'RedHat': {
      $modules_modulepath_default = [
        '/etc/modulefiles',
        '/usr/share/modulefiles',
        '/usr/share/Modules/modulefiles',
      ]
      $modules_package_default = 'environment-modules'
      $modules_conf_sh_default = '/etc/profile.d/modules_puppet.sh'
      $modules_conf_csh_default = '/etc/profile.d/modules_puppet.csh'
      $alias_conf_sh_default = '/etc/profile.d/alias_puppet.sh'
      $alias_conf_csh_default = '/etc/profile.d/alias_puppet.csh'
      $environment_conf_sh_default = '/etc/profile.d/environment_puppet.sh'
      $environment_conf_csh_default = '/etc/profile.d/environment_puppet.csh'
    }
  }

  ## </ OS Defaults >

  ## < Variable assignment >

  if is_bool($modules_manage) == true {
    $modules_manage_real = $modules_manage
  } else {
    $modules_manage_real = str2bool($modules_manage)
  }

  $modulepath_real = $modulepath ? {
    'DEFAULT' => join($modulepath_default, ':'),
    default   => join($modulepath, ':')
  }
  $modules_package_real = $modules_package ? {
    'DEFAULT' => $modules_package_default,
    default   => $modules_package
  }
  $modules_conf_ensure = $modules_manage ? {
    true  => 'present',
    false => 'absent',
  }
  $modules_conf_sh_real = $modules_conf_sh ? {
    'DEFAULT' => $modules_conf_sh_default,
    default   => $modules_conf_sh
  }
  $modules_conf_csh_real = $modules_conf_csh ? {
    'DEFAULT' => $modules_conf_csh_default,
    default   => $modules_conf_csh
  }

  if is_bool($alias_manage) == true {
    $alias_manage_real = $alias_manage
  } else {
    $alias_manage_real = str2bool($alias_manage)
  }
  $alias_conf_ensure = $alias_manage ? {
    true  => 'present',
    false => 'absent',
  }
  $alias_conf_sh_real = $alias_conf_sh ? {
    'DEFAULT' => $alias_conf_sh_default,
    default   => $alias_conf_sh
  }
  $alias_conf_csh_real = $alias_conf_csh ? {
    'DEFAULT' => $alias_conf_csh_default,
    default   => $alias_conf_csh
  }

  if is_bool($environment_manage) == true {
    $environment_manage_real = $environment_manage
  } else {
    $environment_manage_real = str2bool($environment_manage)
  }
  $environment_conf_ensure = $environment_manage ? {
    true  => 'present',
    false => 'absent',
  }
  $environment_conf_sh_real = $environment_conf_sh ? {
    'DEFAULT' => $environment_conf_sh_default,
    default   => $environment_conf_sh
  }
  $environment_conf_csh_real = $environment_conf_csh ? {
    'DEFAULT' => $environment_conf_csh_default,
    default   => $environment_conf_csh
  }

  ## </ Variable assignment >

  ## < Variable validation >

  validate_bool($modules_manage_real)
  validate_bool($alias_manage_real)
  validate_bool($environment_manage_real)

  validate_absolute_path($modules_conf_sh_real)
  validate_absolute_path($modules_conf_csh_real)
  validate_absolute_path($alias_conf_sh_real)
  validate_absolute_path($alias_conf_csh_real)
  validate_absolute_path($environment_conf_sh_real)
  validate_absolute_path($environment_conf_csh_real)

  if $modules_manage_real == true {
    validate_array($modules)
  }
  if $alias_manage_real == true {
    validate_hash($alias)
  }
  if $environment_manage_real == true {
    validate_hash($environment)
  }

  ## </ Variable validation >


  ## < Module environment settings >

  # Install modulecmd package if managing modules.
  if $modules_manage == true {
    package { 'modulecmd':
      ensure => installed,
      name   => $modules_package_real,
    }
  }
  # Load the module settings, will be loaded after modules.(c)sh
  file { 'modules_conf_sh':
    ensure  => $modules_conf_ensure,
    path    => $modules_conf_sh_real,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('modules/environment/modules.sh.erb'),
  }
  file { 'modules_conf_csh':
    ensure  => $modules_conf_ensure,
    path    => $modules_conf_csh_real,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('modules/environment/modules.csh.erb'),
  }

  ## </ Module environment settings >

  ## < Aliases >
  # Environment alias settings
  file { 'alias_conf_sh':
    ensure  => $alias_conf_ensure,
    path    => $alias_conf_sh_real,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('modules/environment/alias.erb'),
  }
  file { 'alias_conf_csh':
    ensure  => $alias_conf_ensure,
    path    => $alias_conf_csh_real,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('modules/environment/alias.erb'),
  }

  ## </ Aliases >

  ## < Environment >
  # Environment variables configuration
  file { 'environment_conf_sh':
    ensure  => $environment_conf_ensure,
    path    => $environment_conf_sh_real,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('modules/environment/environment.sh.erb'),
  }
  file { 'environment_conf_csh':
    ensure  => $environment_conf_ensure,
    path    => $environment_conf_csh_real,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('modules/environment/environment.csh.erb'),
  }

  ## </ Aliases >

}
