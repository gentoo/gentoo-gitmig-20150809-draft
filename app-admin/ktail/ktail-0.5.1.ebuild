# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/ktail/ktail-0.5.1.ebuild,v 1.1 2001/10/09 12:53:48 achim Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION} ktail monitors multiple files and/or command output in one window."

SRC_URI="http://www.franken.de/users/duffy1/rjakob/${P}.tar.gz"

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}




