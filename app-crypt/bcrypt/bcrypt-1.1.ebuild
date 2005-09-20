# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/bcrypt/bcrypt-1.1.ebuild,v 1.9 2005/09/20 19:42:04 grobian Exp $

DESCRIPTION="A file encryption utility using Paul Kocher's implementation of the blowfish algorithm"
HOMEPAGE="http://bcrypt.sourceforge.net/"
SRC_URI="mirror://sourceforge/bcrypt/${P}.tar.gz"
SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha amd64 ppc ~ppc-macos sparc x86"
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
