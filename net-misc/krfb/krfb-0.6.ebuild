# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/krfb/krfb-0.6.ebuild,v 1.8 2002/08/14 12:08:08 murphy Exp $

inherit kde-base || die

LICENSE="GPL-2"
need-kde 3
DESCRIPTION="KDE Desktop Sharing Application"
SRC_URI="http://www.tjansen.de/krfb/${P}.tar.bz2"
HOMEPAGE="http://www.tjansen.de/krfb/"
KEYWORDS="x86 sparc sparc64"

src_install() {

	mkdir -p ${D}/${PREFIX}/share/apps/krfb
	make DESTDIR=${D} install || die

}
