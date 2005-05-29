# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lyx2html/lyx2html-0.2.ebuild,v 1.1 2005/05/29 04:31:55 usata Exp $

inherit toolchain-funcs

DESCRIPTION="A very simple Lyx to HTML command line converter"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"
HOMEPAGE="http://www.netmeister.org/apps/lyx2html/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_compile() {
	make CC=$(tc-getCC) COPTS="${CFLAGS}" || die
}

src_test() {
	cd test
	../lyx2html README.lyx || die
}
src_install() {
	dobin lyx2html || die "Installation failed"
	dodoc CHANGES README
	doman lyx2html.1
}
