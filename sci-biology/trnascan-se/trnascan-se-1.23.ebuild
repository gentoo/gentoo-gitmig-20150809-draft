# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/trnascan-se/trnascan-se-1.23.ebuild,v 1.1 2005/01/30 18:25:40 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="tRNA detection in large-scale genome sequences"
HOMEPAGE="http://selab.wustl.edu/cgi-bin/selab.pl?mode=software%22#trnascan"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/perl"

src_compile() {
	sed -i -e "s%BINDIR  = \$(HOME)/bin%BINDIR  = ${D}/usr/bin%" \
	-e "s%LIBDIR  = \$(HOME)/lib/tRNAscan-SE%LIBDIR  = ${D}/usr/share/${PN}%" \
	-e "s%MANDIR  = \$(HOME)/man%MANDIR  = ${D}/usr/share/man%" \
	-e "s%CC = gcc%CC = $(tc-getCC)%" \
	-e "s%CFLAGS = -O%CFLAGS = ${CFLAGS}%" \
	Makefile || die
	emake || die
}

src_install() {
	make install || die
	dodoc MANUAL README Release.history
	insinto /usr/share/doc/${PF}
	doins Manual.ps
}

src_test() {
	make testrun || die
}
