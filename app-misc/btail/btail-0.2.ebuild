# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/btail/btail-0.2.ebuild,v 1.2 2006/06/11 14:49:41 stuart Exp $

inherit eutils

DESCRIPTION="Bayesian logfile filter"
HOMEPAGE="http://www.vanheusden.com/btail/"
SRC_URI="${HOMEPAGE}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
#RESTRICT="nostrip"

DEPEND="sys-libs/gdbm"
#RDEPEND=""

src_unpack() {
	unpack ${A}; cd ${S}

	sed -i -e 1iCXX=$(tc-getCXX) \
		-e "s,^\(CXXFLAGS=\).*$,\1${CXXFLAGS}," \
		-e "s,^\(LDFLAGS=\),&${LDFLAGS} ," \
		-e "s,\$(CC) -Wall -W,$(tc-getCXX)," \
		Makefile
}

src_install() {
	dobin blearn || die
	dobin btail || die

	dodoc readme.txt || die
	dodoc btail.conf || die
	dodoc license.txt || die
}
