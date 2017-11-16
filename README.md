venvc
=====

Python virtualenv controller with bash


Function
--------

- create virtualenv
- update installed packages
- export installed package list
- reinstall packages
- remove virtualenv


Settings
--------

- copy and edit configuration file for your envoronment

	$ cp venvc.conf.example venvc.conf
	$ _YOUR-EDITOR_ venvc.conf

- configuration
    - PYVENV      : path to command(python, pyvenv or viurtualenv)
    - VENV_DIR    : directory for virtualenv
    - EXPORT_FILE : filename for export and reinstall


Usage
-----

- create virtualenv

	$ venvc.sh create

- update installed packages

	$ venvc.sh update

- export installed package list

	$ venvc.sh export

- reinstall packages

	$ venvc.sh reinstall

- remove virtualenv
    - This is not remove export file.
    - When you want update python version in virtualenv,
      execute export, remove, create and reinstall.

	$ venvc.sh remove

- auto
    - This command execute "create", "reinstall", "update" and "export".

	$ vevnc.sh auto
