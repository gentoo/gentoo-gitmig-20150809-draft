# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ttyrec/ttyrec-1.0.6.ebuild,v 1.9 2004/09/16 01:31:23 pvdabeel Exp $

DESCRIPTION="tty recorder"
HOMEPAGE="http://namazu.org/~satoru/ttyrec/"
SRC_URI="http://namazu.org/~satoru/ttyrec/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 macos ppc64 ~alpha ppc-macos"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	make CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin ttyrec ttyplay ttytime || die
	dodoc README
	doman *.1
}
