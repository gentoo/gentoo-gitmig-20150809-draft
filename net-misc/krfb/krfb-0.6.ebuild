# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/krfb/krfb-0.6.ebuild,v 1.12 2003/02/13 14:58:01 vapier Exp $

inherit kde-base

LICENSE="GPL-2"
need-kde 3
DESCRIPTION="KDE Desktop Sharing Application"
SRC_URI="http://www.tjansen.de/krfb/${P}.tar.bz2"
HOMEPAGE="http://www.tjansen.de/krfb/"
KEYWORDS="x86 sparc "

src_install() {
	dodir /${PREFIX}/share/apps/krfb
	make DESTDIR=${D} install || die
}
