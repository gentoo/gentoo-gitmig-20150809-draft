# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-xmmsbar/karamba-xmmsbar-0.3.ebuild,v 1.8 2004/09/02 18:22:39 pvdabeel Exp $

S=${WORKDIR}/${PN}

DESCRIPTION="XMMS plugin for Karamba"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5882"
SRC_URI="http://www.kde-look.org/content/files/5882-xmmsbar-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND=">=x11-misc/superkaramba-0.21
	>=media-sound/xmmsctrl-1.6"

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
