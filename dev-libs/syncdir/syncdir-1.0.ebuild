# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/syncdir/syncdir-1.0.ebuild,v 1.14 2012/12/01 19:50:24 armin76 Exp $

inherit toolchain-funcs

DESCRIPTION="Provides an alternate implementation for open, link, rename, and unlink "
HOMEPAGE="http://untroubled.org/syncdir"
SRC_URI="http://untroubled.org/syncdir/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

RDEPEND=""

src_compile() {
	emake CC="$(tc-getCC)" || die "compile problem"
}

src_install () {
	dodir /usr
	dodir /usr/lib

	make prefix="${D}"/usr install || die "install problem"

	dodoc testsync.c
}
