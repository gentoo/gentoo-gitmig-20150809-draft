# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-tuxbar/karamba-tuxbar-0.17g.ebuild,v 1.1 2003/05/04 04:15:22 prez Exp $

DESCRIPTION="Rolling menu plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5812"
SRC_URI="http://www.kdelook.org/content/files/5812-tuxbar-pzoom-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=x11-misc/superkaramba-0.21"

src_unpack () {
	unpack ${A}
	mv tuxbar ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/tuxbar
	cp tuxbar.theme ${D}/usr/share/karamba/themes/tuxbar
	cp tuxbar.py ${D}/usr/share/karamba/themes/tuxbar
	cp -r pics ${D}/usr/share/karamba/themes/tuxbar
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/tuxbar

	dodoc README
}
