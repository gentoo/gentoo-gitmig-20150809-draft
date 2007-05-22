# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/trnascan-se/trnascan-se-1.23-r1.ebuild,v 1.5 2007/05/22 01:22:13 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="tRNA detection in large-scale genome sequences"
HOMEPAGE="http://selab.wustl.edu/cgi-bin/selab.pl?mode=software#trnascan"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s%BINDIR  = \$(HOME)/bin%BINDIR = /usr/bin%" \
		-e "s%LIBDIR  = \$(HOME)/lib/tRNAscan-SE%LIBDIR = /usr/lib/${PN}%" \
		-e "s%MANDIR  = \$(HOME)/man%MANDIR = /usr/share/man%" \
		-e "s%CC = gcc%CC = $(tc-getCC)%" \
		-e "s%CFLAGS = -O%CFLAGS = ${CFLAGS}%" \
		-i Makefile || die
}

src_compile() {
	emake || die
	mv tRNAscan-SE.man tRNAscan-SE.man.1 || die
}

src_install() {
	dobin covels-SE coves-SE eufindtRNA tRNAscan-SE trnascan-1.4 || die
	doman tRNAscan-SE.man.1 || die
	dodoc MANUAL README Release.history || die
	insinto /usr/lib/${PN}/
	doins *.cm gcode.* Dsignal TPCsignal || die
	insinto /usr/share/doc/${PF}
	doins Manual.ps || die
}

src_test() {
	make testrun || die
}
