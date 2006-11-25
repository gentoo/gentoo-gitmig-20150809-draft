# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fujiplay/fujiplay-1.33.ebuild,v 1.12 2006/11/25 01:11:15 masterdriverz Exp $

inherit eutils

DESCRIPTION="Utility for Fujifilm/Leica digital cameras (via serial port)"
HOMEPAGE="http://topo.math.u-psud.fr/~bousch/fujiplay.html"
SRC_URI="http://topo.math.u-psud.fr/~bousch/fujiplay.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${PN}.tgz
	cd ${S}
	epatch ${FILESDIR}/${P}-unterminated-strings.patch
}

src_install() {
	dobin fujiplay yycc2ppm || die
	dodoc README fujiplay.lsm mx700-commands.html
	emake all clean
}

pkg_postinst() {
	ln -s /dev/ttyS0 /dev/fujifilm
	einfo "A symbolic link /dev/ttyS0 -> /dev/fujifilm was created."
	einfo "You may want to create a serial group to allow non-root"
	einfo "members R/W access to the serial device."
	echo
}

pkg_postrm() {
	rm -f /dev/fujifilm
	echo
	einfo "The symbolic link /dev/fujifilm was removed."
	echo
}
