# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws/files/plugins-rebuild.sh,v 1.1 2006/10/26 14:39:21 genone Exp $
#!/bin/bash

echo "Looking for sylpheed-claws plugins to rebuild ..."
cd ${ROOT}/var/db/pkg
PLUGINS=$(for d in mail-client/sylpheed-claws-[a-z]*; do /usr/lib/portage/bin/pkgname $d | cut -d' ' -f 1; done)
echo
echo "Found plugins:"
echo "${PLUGINS}"
echo
echo "Rebuilding with given emerge options: $*"
sleep 2
emerge $* ${PLUGINS}
