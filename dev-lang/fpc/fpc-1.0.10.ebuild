# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-1.0.10.ebuild,v 1.9 2005/01/19 02:41:13 chriswhite Exp $

DESCRIPTION="The Free Pascal compiler"
HOMEPAGE="http://www.freepascal.org/"
SRC_URI="mirror://gentoo/${P}.tbz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -*"
IUSE=""
DEPEND="virtual/libc
	!dev-lang/fpc-source"
RDEPEND="virtual/libc"
S=${WORKDIR}

src_unpack() {
	einfo unpacking done in install phase
}

src_compile() {
	einfo Nothing to compile
}

src_install() {
	einfo Unpacking to image directory
	einfo This may take some time depending on your system
	tar -xjf ${DISTDIR}/${P}.tbz2 -C ${D}
}

pkg_postinst() {
	einfo Setting up configuration
	${ROOT}/opt/fpc/lib/fpc/${PV}/samplecfg ${ROOT}/opt/fpc/lib/fpc/${PV} /etc
}
