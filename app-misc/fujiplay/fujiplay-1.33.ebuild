# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fujiplay/fujiplay-1.33.ebuild,v 1.2 2003/06/12 20:16:36 msterret Exp $

DESCRIPTION="Utility for Fujifilm/Leica digital cameras (via serial port)"
SRC_URI="http://topo.math.u-psud.fr/~bousch/fujiplay.tgz"
HOMEPAGE="http://topo.math.u-psud.fr/~bousch/fujiplay.html"

SLOT="0"
KEYWORDS="x86"
LICENSE="public-domain"

DEPEND="virtual/glibc"
RDEPEND=""

S=${WORKDIR}

src_compile() {
#	bash
	cd fujiplay-1.33
	emake || die 
}

src_install() {
        cd fujiplay-1.33
	into /usr
	dobin fujiplay yycc2ppm
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

