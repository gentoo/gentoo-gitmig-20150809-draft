# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cproto/cproto-4.6-r1.ebuild,v 1.8 2005/11/10 20:37:15 grobian Exp $

inherit eutils

DESCRIPTION="generate C function prototypes from C source code"
HOMEPAGE="http://cproto.sourceforge.net//"
SRC_URI="mirror://sourceforge/cproto/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ppc ~ppc-macos x86"
IUSE=""

DEPEND="virtual/libc"

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
