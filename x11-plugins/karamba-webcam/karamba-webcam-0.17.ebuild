# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-webcam/karamba-webcam-0.17.ebuild,v 1.1 2003/05/04 06:00:26 prez Exp $

DESCRIPTION="Webcam plugin for Karamba"
HOMEPAGE="http://www.efd.lth.se/~d98hk/karamba/"
SRC_URI="http://www.efd.lth.se/~d98hk/karamba/karcam.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="|| ( >=x11-misc/karamba-0.17 >=x11-misc/superkaramba-0.21 )"

src_unpack () {
	unpack ${A}
	mv karcam ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/bin /usr/share/karamba/themes/webcam
	cp scripts/wcam ${D}/usr/share/karamba/bin
	chmod 755 ${D}/usr/share/karamba/bin

	sed -e 's#/home/bosselut/#~/#g' themes/webcam.theme \
		>${D}/usr/share/karamba/themes/webcam/webcam.theme
	cp -r themes/pics ${D}/usr/share/karamba/themes/webcam/
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/webcam
}
