# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ww/ww-2.26.ebuild,v 1.3 2004/11/23 20:58:52 squinky86 Exp $

DESCRIPTION="White Water allows people to publish files for download by thousands of people without saturating their bandwidth."
HOMEPAGE="http://ww.walrond.org"
SRC_URI="ftp://ftp.walrond.org/ww/${P}.tar.bz2"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=dev-libs/openssl-0.9.7"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:-O3:${CFLAGS}:g' Makefile */Makefile
}

src_compile() {
	make clean || die "make clean"
	make deps || die "make deps"
	make release || die "make release"
}

src_install() {
	dodoc INSTALL README
	dohtml -r www
	dobin ww
}
