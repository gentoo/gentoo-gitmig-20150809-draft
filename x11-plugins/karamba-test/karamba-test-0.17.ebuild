# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-test/karamba-test-0.17.ebuild,v 1.3 2003/05/04 06:01:50 prez Exp $

DESCRIPTION="Default plugins for Karamba"
HOMEPAGE="http://www.efd.lth.se/~d98hk/karamba/"
SRC_URI="http://www.efd.lth.se/~d98hk/karamba/karamba_test.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="|| ( >=x11-misc/karamba-0.17 >=x11-misc/superkaramba-0.21 )"

src_unpack () {
	unpack ${A}
	mv karamba_test ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/themes/test
	cp -r * ${D}/usr/share/karamba/themes/test/
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/test
}
