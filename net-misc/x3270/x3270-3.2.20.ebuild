# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/x3270/x3270-3.2.20.ebuild,v 1.1 2003/07/28 03:18:33 robbat2 Exp $

IUSE=""

S="${WORKDIR}/${PN}-3.2"
DESCRIPTION="Telnet 3270 client for X"
SRC_URI="http://x3270.bgp.nu/download/${PN}-${PV//.}.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/Peaks/7814/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11"

src_compile() {
	econf --with-x || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm ${D}/usr/X11R6/lib/X11/fonts/misc/fonts.dir
}

pkg_postinst() {
	einfo ">>> Running mkfontdir on /usr/X11R6/lib/X11/fonts/misc"
	mkfontdir /usr/lib/X11/fonts/misc
}

pkg_postrm() {
	einfo ">>> Running mkfontdir on /usr/X11R6/lib/X11/fonts/misc"
	mkfontdir /usr/lib/X11/fonts/misc
}
