# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-2.2.1.ebuild,v 1.3 2001/09/29 12:42:18 danarmak Exp $

DESCRIPTION="KDE 2.2 environment settings (KDEDIR)"
HOMEPAGE="http://www.kde.org/"

src_install() {

	if [ "`ls /etc/env.d/90kde2*`" ]; then
		echo "ERROR: you MUST unmerge previous versions of kde, and of kde-env
in particular, before merging this new one. Adieu!"
		exit 1
	fi
	echo "Ignore any errors from the ls command above"

	insinto /etc/env.d
	doins ${FILESDIR}/90kde

}


