# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/utrac/utrac-0.3.0.ebuild,v 1.3 2009/09/23 16:42:36 patrick Exp $

IUSE=""
DESCRIPTION="Universal Text Recognizer and Converter"
HOMEPAGE="http://utrac.sourceforge.net/"
SRC_URI="http://utrac.sourceforge.net/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
RDEPEND=""
DEPEND="${RDEPEND} sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s:^CFLAGS = .*$:CFLAGS = ${CFLAGS}:" \
		-e "s:^PREFIX_PATH = .*$:PREFIX_PATH = ${DESTTREE}:" \
		Makefile \
		|| die "sed failed"
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin utrac
	doman utrac.1
	dodoc README CHANGES CREDITS
	dodir ${DESTTREE}/share/utrac
	dolib.a libutrac.a
	insinto ${DESTTREE}/share/utrac
	doins charsets.dat
}
