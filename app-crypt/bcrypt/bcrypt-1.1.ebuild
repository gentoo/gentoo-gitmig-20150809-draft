# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcrypt/bcrypt-1.1.ebuild,v 1.4 2004/03/13 21:50:28 mr_bones_ Exp $

DESCRIPTION="A file encryption utility using Paul Kocher's implementation of the blowfish algorithm"
HOMEPAGE="http://bcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/bcrypt/${P}.tar.gz"
SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""
DEPEND="sys-libs/zlib"

src_compile() {
	sed -i -e "s:CFLAGS = -O2 -Wall:CFLAGS = -Wall ${CFLAGS}:" Makefile
	make || die
}

src_install() {
	dobin bcrypt
	dodoc LICENSE README
	doman bcrypt.1
}
