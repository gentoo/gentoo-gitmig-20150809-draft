# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cproto/cproto-4.6.ebuild,v 1.7 2004/08/25 02:22:24 swegener Exp $

IUSE=""

DESCRIPTION="generate C function prototypes from C source code"
SRC_URI="mirror://sourceforge/cproto/cproto-4.6.tar.gz"
HOMEPAGE="http://cproto.sourceforge.net/"

SLOT="0"
KEYWORDS="x86"
LICENSE="public-domain"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	patch -p1 < ${FILESDIR}/${P}-mkstemp.patch
}

src_compile() {
	econf || die "./configure failed"
	emake
}

src_install() {

	dodir /usr/bin
	dobin cproto
	doman cproto.1
	dodoc README CHANGES
}
