
# puppet-module-environment #
===

Puppet Module to manage various environment settings. It allows editing of aliases, generic environment variables and modules loaded by the environment modules system.

# Compatability #

This module provides OS default values for these OSfamilies:

 * RedHat

# TODO #

This module will need spec tests.

# Parameters #

modules_manage
--------------
Enable management of the environment modules system.

- *Module Default*: false

modules
-------
An array of module names to load

- *Module Default*: undef

Hiera example:
<pre>
environment::modules:
  - 'jdk/1.8_25'
  - 'maven'
  - 'ant'
</pre>

modules_modulepath
------------------
An array of paths in which the environment module definitions can be found

- *Module Default*: undef

modules_package
---------------
Package to be installed by the OS package manager to enable environment modules.

- *Module Default*: 'DEFAULT'

modules_conf_sh
---------------
Path of the environment modules configuration in borne shell syntax.

- *Module Default*: 'DEFAULT'

modules_conf_csh
----------------
Path of the environment modules configuration in c-shell syntax.

- *Module Default*: 'DEFAULT'

alias_manage
------------
Enable management of aliases

- *Module Default*: false

alias
-----
Hash of aliases that will be configured

- *Module Default*: undef

Hiera example:
<pre>
environment::alias:
  'rm': 'rm -i'
  'cp': 'cp -i'
  'ls': 'ls -shal'
</pre>

alias_conf_sh
-------------
Path of the alias configuration in borne shell syntax.

- *Module Default*: 'DEFAULT'

alias_conf_csh
--------------
Path of the alias modules configuration in c-shell syntax.

- *Module Default*: 'DEFAULT'

environment_manage
------------------
Enable management of environment variables

- *Module Default*: false

environment
-----------
Hash of environment variables that will be set.

- *Module Default*: undef

Hiera example:
<pre>
environment::environment:
  'http_proxy': 'http://proxy.example.com'
  'https_proxy': 'http://proxy.example.com'
  'ftp_proxy': 'http://proxy.example.com'
  'no_proxy': '127.0.0.0/8, proxy.example.com'
</pre>

environment_conf_sh
-------------
Path of the evironment variable configuration in borne shell syntax.

- *Module Default*: 'DEFAULT'

environment_conf_csh
--------------
Path of the environment variable modules configuration in c-shell syntax.

- *Module Default*: 'DEFAULT'
