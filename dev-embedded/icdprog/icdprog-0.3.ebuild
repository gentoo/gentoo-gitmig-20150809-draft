# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/icdprog/icdprog-0.3.ebuild,v 1.2 2004/03/05 09:22:46 dragonheart Exp $

DESCRIPTION="Microchip PIC Programmer using ICD hardware"
HOMEPAGE="http://${PN}.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-devel/gcc
	>=sys-apps/sed-4"
RDEPEND="" #we don't depend on anything after we are compiled
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	for f in ${S}/src/Makefile ${S}/src/icddump/Makefile; do
		sed -e 's|^CFLAGS.*|CFLAGS += -Wall|' -i ${f}
	done
}

src_compile() {
	cd ${S}/src
	emake
	cd ${S}/src/icddump
	emake
}

src_install() {
	dobin src/icdprog
	dobin src/icddump/icddump
	dodoc README src/README.coders
}

pkg_postinst() {
	einfo "Please read the README if the ICD seems to be very slow."
}
