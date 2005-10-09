# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwag/netwag-5.28.0.ebuild,v 1.3 2005/10/09 11:31:15 mkay Exp $

DESCRIPTION="Tcl/tk interface to netwox (Toolbox of 212 utilities for testing Ethernet/IP networks)"
HOMEPAGE="http://www.laurentconstantin.com/en/netw/netwag/"
SRC_URI="http://www.laurentconstantin.com/common/netw/${PN}/download/v${PV/.*}/${P}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="~net-analyzer/netwox-${PV}
	>=dev-lang/tk-8"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	sed -i \
		-e 's:/usr/local:/usr:g' \
		${S}/src/config.dat
}

src_compile() {
	cd src
	./genemake || die "problem creating Makefile"
	emake -j1 CC=$(tc-getCC) || die "compile problem"
}

src_install() {
	dodoc README.TXT doc/*.txt
	cd src
	make install DESTDIR=${D} INSTMAN1=${D}/usr/share/man/man1 || die
}
