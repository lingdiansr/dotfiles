#!/bin/bash
lookandfeeltool -a Catppuccin-Latte-Sky
# plasma-apply-desktoptheme breeze-light
kwriteconfig6 --file kdeglobals --group Icons --key Theme "Tela-light"
plasmashell --replace &
