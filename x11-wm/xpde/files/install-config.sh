#!/bin/bash

if [ ! -d ${HOME}/.xpde ]
then
	cp -r /opt/xpde/share/defaultdesktop ~/.xpde
	cp /opt/xpde/share/xinitrcDEFAULT ~/startXPDE
	chmod +x ~/startXPDE
	
fi

echo "To use XPDE, add '~/startXPDE' to you .xinitrc"

