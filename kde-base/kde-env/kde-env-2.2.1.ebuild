# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-env/kde-env-2.2.1.ebuild,v 1.1 2001/09/19 06:24:04 danarmak Exp $

DESCRIPTION="KDE 2.2 environment settings (KDEDIR)"
HOMEPAGE="http://www.kde.org/"

src_install() {

	insinto /etc/env.d
	doins ${FILESDIR}/90kde${PV}
}
