# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cproto/cproto-4.6-r1.ebuild,v 1.3 2004/04/25 21:32:28 vapier Exp $

inherit eutils

DESCRIPTION="generate C function prototypes from C source code"
HOMEPAGE="http://cproto.sourceforge.net//"
SRC_URI="mirror://sourceforge/cproto/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-mkstemp.patch
	epatch ${FILESDIR}/${PV}-YYSTYPE.patch
}

src_install() {
	dobin cproto || die
	doman cproto.1
	dodoc README CHANGES
}
