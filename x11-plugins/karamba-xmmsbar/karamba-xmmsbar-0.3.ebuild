# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-xmmsbar/karamba-xmmsbar-0.3.ebuild,v 1.2 2003/05/04 06:01:50 prez Exp $

DESCRIPTION="XMMS plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5882"
SRC_URI="http://www.kdelook.org/content/files/5882-xmmsbar-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=x11-misc/superkaramba-0.21
	>=media-sound/xmmsctrl-1.6"

src_unpack () {
	unpack ${A}
	mv xmmsbar ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/xmmsbar
	cp xmmsbar.theme ${D}/usr/share/karamba/themes/xmmsbar
	cp xmmsbar.py ${D}/usr/share/karamba/themes/xmmsbar
	cp -r pics ${D}/usr/share/karamba/themes/xmmsbar
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/xmmsbar

	dodoc README
}
