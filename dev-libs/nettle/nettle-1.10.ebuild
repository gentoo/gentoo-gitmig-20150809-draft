# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nettle/nettle-1.10.ebuild,v 1.10 2007/07/12 02:25:35 mr_bones_ Exp $

DESCRIPTION="cryptographic library that is designed to fit easily in any context"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"
SRC_URI="http://www.lysator.liu.se/~nisse/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

DEPEND="virtual/libc
	dev-libs/gmp
	!<dev-libs/lsh-1.4.3-r1"

src_compile() {
	# BUG #55238 is valid. We need a shared library as well.
	# Danny van Dyk <kugelfang@gentoo.org> 2004/10/01
	econf --enable-shared || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
