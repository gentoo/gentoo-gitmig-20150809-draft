# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-bluebar_kroller/karamba-bluebar_kroller-0.84.ebuild,v 1.1 2003/05/04 09:37:05 prez Exp $

DESCRIPTION="Kroller and Bluebar plugins together for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5972"
SRC_URI="http://www.kdelook.org/content/files/5972-bluebar%20kroller.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=x11-misc/superkaramba-0.21
	media-plugins/xmms-find
	media-sound/xmmsctrl"

src_unpack () {
	unpack ${A}
	mv bluebar_pub ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/bluebar_kroller
	sed -e 's#import karamba#import karamba\nimport os#' \
		-e 's#"/home/nonooo/boulot/bluebar_pub/bluebar.conf#os.environ["HOME"] + "/.karamba/bluebar_kroller.conf#' \
		bluebar.py > ${D}/usr/share/karamba/themes/bluebar_kroller/bluebar_kroller.py
	sed -e 's#/home/petros/.bin/##g' \
		-e 's/#CLICKAREA/CLICKAREA/g' bluebar.theme \
		> ${D}/usr/share/karamba/themes/bluebar_kroller/bluebar_kroller.theme
	cp -r icons ${D}/usr/share/karamba/themes/bluebar_kroller
	cp -r pics ${D}/usr/share/karamba/themes/bluebar_kroller
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/bluebar_kroller

	mv bluebar.conf bluebar_kroller.conf

	dodoc bluebar_kroller.conf
}
