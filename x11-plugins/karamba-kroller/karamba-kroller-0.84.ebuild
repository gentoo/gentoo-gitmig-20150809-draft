# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-kroller/karamba-kroller-0.84.ebuild,v 1.2 2003/05/04 06:01:50 prez Exp $

DESCRIPTION="Rolling menu plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5931"
SRC_URI="http://www.kdelook.org/content/files/5931-kroller-v${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=x11-misc/superkaramba-0.21"

src_unpack () {
	unpack ${A}
	mv kroller-v${PV} ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/kroller
	sed -e 's#import karamba#import karamba\nimport os#' \
		-e 's#"/your/path/to/kroller.conf#os.environ["HOME"] + "/.karamba/kroller.conf#' \
		kroller.py > ${D}/usr/share/karamba/themes/kroller/kroller.py
	cp kroller.theme ${D}/usr/share/karamba/themes/kroller
	cp -r icons ${D}/usr/share/karamba/themes/kroller
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/kroller

	dodoc README CHANGELOG INSTALL kroller.conf
}
