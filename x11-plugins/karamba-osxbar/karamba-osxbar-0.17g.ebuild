# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-osxbar/karamba-osxbar-0.17g.ebuild,v 1.1 2003/05/04 04:05:09 prez Exp $

DESCRIPTION="Rolling menu plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5843"
SRC_URI="http://www.kdelook.org/content/files/5843-osxbar-superkaramba-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=x11-misc/superkaramba-0.21"

src_unpack () {
	unpack ${A}
	mv osxbar-superkaramba ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/osxbar
	cp macosx.theme ${D}/usr/share/karamba/themes/osxbar/osxbar.theme
	cp macosxbar.theme ${D}/usr/share/karamba/themes/osxbar
	cp macosxbar2.theme ${D}/usr/share/karamba/themes/osxbar
	cp macosxbar.py ${D}/usr/share/karamba/themes/osxbar
	cp Lucidagrande.ttf ${D}/usr/share/karamba/themes/osxbar
	cp Aqua_Blue.jpg ${D}/usr/share/karamba/themes/osxbar
	cp -r pics ${D}/usr/share/karamba/themes/osxbar
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/osxbar

	dodoc readme.txt ChangeLog
}
