# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ttyrec/ttyrec-1.0.6.ebuild,v 1.12 2004/10/23 08:14:04 mr_bones_ Exp $

DESCRIPTION="tty recorder"
HOMEPAGE="http://namazu.org/~satoru/ttyrec/"
SRC_URI="http://namazu.org/~satoru/ttyrec/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc64 ~alpha ppc-macos ~sparc ~ppc"
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
