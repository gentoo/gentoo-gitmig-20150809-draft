# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcrypt/bcrypt-1.1.ebuild,v 1.2 2003/09/21 09:44:08 aliz Exp $

DESCRIPTION="A file encryption utility using Paul Kocher's implementation of the blowfish algorithm"
HOMEPAGE="http://bcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/bcrypt/${P}.tar.gz"
SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""
DEPEND="sys-libs/zlib"

src_compile() {
	sed -e "s:CFLAGS = -O2 -Wall:CFLAGS = -Wall ${CFLAGS}:" Makefile > Makefile.new
	mv Makefile.new Makefile
	make || die
}

src_install() {
	dobin bcrypt
	dodoc LICENSE README
	doman bcrypt.1
}
