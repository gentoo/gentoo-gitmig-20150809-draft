# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-2.2.1.ebuild,v 1.4 2001/10/17 20:21:26 danarmak Exp $

DESCRIPTION="KDE 2.2 environment settings (KDEDIR)"
HOMEPAGE="http://www.kde.org/"

src_install() {

	if [ "`ls /etc/env.d/90kde2*`" ]; then
		echo "A previous version of kde-env has been detected. For now, please manually
unmerge it before merging this new version.
If there is none installed, manually remove /etc/env.d/90kde*"
		exit 1
	fi
	echo "Ignore any errors from the ls command above"

	insinto /etc/env.d
	doins ${FILESDIR}/90kde

}


