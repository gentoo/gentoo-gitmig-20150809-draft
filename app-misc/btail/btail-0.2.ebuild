# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/btail/btail-0.2.ebuild,v 1.5 2008/12/30 19:33:14 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Bayesian logfile filter"
HOMEPAGE="http://www.vanheusden.com/btail/"
SRC_URI="${HOMEPAGE}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="sys-libs/gdbm"

src_unpack() {
	unpack ${A}
	sed -i -e "/^LDFLAGS/s/$/ ${LDFLAGS}/" "${S}"/Makefile
}

src_compile() {
	emake CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		|| die "emake failed"
}

src_install() {
	dobin blearn || die
	dobin btail || die

	dodoc readme.txt || die
	dodoc btail.conf || die
	dodoc license.txt || die
}
