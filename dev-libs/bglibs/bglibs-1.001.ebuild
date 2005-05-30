# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/bglibs/bglibs-1.001.ebuild,v 1.12 2005/05/30 18:22:57 swegener Exp $

inherit toolchain-funcs

DESCRIPTION="Bruce Guenters library package"
HOMEPAGE="http://untroubled.org/bglibs/"
SRC_URI="http://untroubled.org/bglibs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	echo "${D}/usr/lib/bglibs" > conf-home
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	emake -j1 || die
}

src_install () {
	dodir /usr/lib/bglibs
	./installer || die "install failed"
}
