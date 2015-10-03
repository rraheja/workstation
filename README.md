workstation
===========

Description
-----------

Scripts for setting up and maintaining a development workstation on Mac OS X or Linux.

Installation
------------
To setup a new machine, clone the repository, edit the software list, backup locations etc. and then run the scripts. For example, to install/upgrade software:

```bash
git clone git@github.com:rraheja/workstation.git ~/.workstation && ~/.workstation/setup.sh
````

Using curl to install software on the workstation (software list is in the setup script)
```bash
curl -L https://raw.githubusercontent.com/rraheja/workstation/master/setup.sh | sh
````

*OPTIONAL:* Install the "dotfiles" using the "dotfiles" repo.
