# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/krfb/krfb-0.5.1.ebuild,v 1.9 2002/12/09 04:33:16 manson Exp $ 

inherit kde-base

need-kde 2.2
DESCRIPTION="KDE Desktop Sharing Application"
SRC_URI="http://www.tjansen.de/krfb/${PN}-0.5.tar.gz"
HOMEPAGE="http://www.tjansen.de/krfb/"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"

src_install() {
	dodir /${PREFIX}/share/apps/krfb
	make DESTDIR=${D} install || die
}
