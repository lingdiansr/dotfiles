#!/bin/bash
lookandfeeltool -a Catppuccin-Mocha-Sky
# plasma-apply-desktoptheme breeze-dark
kwriteconfig6 --file kdeglobals --group Icons --key Theme "Tela-dark"
plasmashell --replace &
