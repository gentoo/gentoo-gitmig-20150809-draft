# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail/files/plugins-rebuild.sh,v 1.2 2006/12/19 18:30:06 ticho Exp $
#!/bin/bash

if [ -d ${ROOT}/var/db/pkg ]; then
	cd ${ROOT}/var/db/pkg
else
	echo "ERROR: package database not found"
	exit 1
fi

if ls -d mail-client/sylpheed-claws-[a-z]* &> /dev/null; then
	echo "Looking for sylpheed-claws plugins to rename ..."
	OLDPLUGINS=$(for d in mail-client/sylpheed-claws-[a-z]*; do /usr/lib/portage/bin/pkgname $d | cut -d' ' -f 1; done)
	echo 
	echo "Found old plugins for rename:"
	echo "${OLDPLUGINS}"
	echo
	echo "Unmerging old plugins to prevent file collisions..."
	echo
	emerge -C $* ${OLDPLUGINS}
	echo
	echo "Installing renamed versions with given emerge options: $*"
	echo
	sleep 2
	emerge $* ${OLDPLUGINS//sylpheed-claws/claws-mail}
elif ls -d mail-client/claws-mail-[a-z]* &> /dev/null; then
	echo "Looking for claws-mail plugins to rebuild ..."
	PLUGINS=$(for d in mail-client/claws-mail-[a-z]*; do /usr/lib/portage/bin/pkgname $d | cut -d' ' -f 1; done)
	echo
	echo "Found plugins for rebuilding:"
	echo "${PLUGINS}"
	echo
	echo "Rebuilding with given emerge options: $*"
	sleep 2
	emerge $* ${PLUGINS}
fi
if [ -z "${PLUGINS}${OLDPLUGINS}" ]; then
	echo
	echo "No plugins found."
	echo
fi
