# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pasm/pasm-1.6c.ebuild,v 1.1 2004/02/28 15:37:38 dholm Exp $


S="${WORKDIR}/${P}"
DESCRIPTION="pasm is a portable assembler for processors of the PowerPC family."
SRC_URI="http://devnull.owl.de/~frank/${PN}.tar.gz"
HOMEPAGE="http://devnull.owl.de/~frank/pasm_e.html"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~ppc"

src_unpack() {
	mkdir -p ${S}
	mkdir -p ${S}/LinuxPPC
	cd ${S}
	unpack ${A}
	epatch ${FILESDIR}/${P}-ppc.patch
}

src_compile() {
	emake || die
}

src_install () {
	dobin pasm
	dodoc pasm.doc
}
