# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pasm/pasm-1.7.ebuild,v 1.1 2004/04/24 22:09:46 dholm Exp $

inherit eutils

DESCRIPTION="A portable assembler for processors of the PowerPC family"
SRC_URI="http://devnull.owl.de/~frank/${PN}.tar.gz"
HOMEPAGE="http://devnull.owl.de/~frank/pasm_e.html"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~ppc"

src_unpack() {
	mkdir -p ${S}/LinuxPPC
	cd ${S}
	unpack ${A}
	epatch ${FILESDIR}/${P}-ppc.patch
}

src_compile() {
	emake || die "Compilation failed"
}

src_install () {
	dobin pasm || die "Failed to install pasm binary"
	dodoc pasm.doc || die "Failed to install pasm documentation"
}
