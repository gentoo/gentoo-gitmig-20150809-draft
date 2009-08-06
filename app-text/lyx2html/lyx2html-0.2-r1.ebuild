# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/lyx2html/lyx2html-0.2-r1.ebuild,v 1.1 2009/08/06 11:58:13 aballier Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A very simple Lyx to HTML command line converter"
SRC_URI="http://www.netmeister.org/apps/${P}.tar.gz"
HOMEPAGE="http://www.netmeister.org/apps/lyx2html/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-alloc.patch"
	epatch "${FILESDIR}/${P}-ldflags.patch"
}

src_compile() {
	emake CC=$(tc-getCC) COPTS="${CFLAGS}" || die
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
