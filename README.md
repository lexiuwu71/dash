# D.A.S.H
Digtial Access and Service Hub

## To install
chmod +x setup.sh
Install a fresh copy of Alpine Linux
Get D.A.S.H onto your computer somehow (through git, wget, usb, cdrom)
Run 'setup.sh' as root
(the installer relies on relative files, so you must be in the dash directory)

(the installer works completely offline and doesn't rely on any server, *except* alpine's repo, but i will be adding a script to create a package cache in a later version)

## To update
Get D.A.S.H onto your computer, run 'setup.sh' as root in the dash directory
(i still have to make it copy over config files to existing user directories)

## This is still in development, so definitaly dont try to install it on any main system :P
## PLEASE read the code before installing