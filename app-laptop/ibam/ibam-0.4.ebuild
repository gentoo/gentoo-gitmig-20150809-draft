# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/ibam/ibam-0.4.ebuild,v 1.3 2007/01/23 16:15:53 genone Exp $

inherit toolchain-funcs

DESCRIPTION="Intelligent Battery Monitor"
HOMEPAGE="http://ibam.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""

DEPEND="sys-apps/sed"
RDEPEND=""

src_unpack() {
	unpack ${A}

	sed -i \
		-e "s:^CFLAGS=-O3:CFLAGS=${CFLAGS}:" \
		-e "s:^CC=g++:CC=$(tc-getCXX):" \
		${S}/Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin ibam

	dodoc CHANGES README REPORT
}

pkg_postinst() {
	elog
	elog "You will need to install media-gfx/gnuplot if you wish to use"
	elog "the --plot argument to ibam."
	elog
}
