# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ttyrec/ttyrec-1.0.6.ebuild,v 1.17 2005/09/09 17:42:59 agriffis Exp $

DESCRIPTION="tty recorder"
HOMEPAGE="http://namazu.org/~satoru/ttyrec/"
SRC_URI="http://namazu.org/~satoru/ttyrec/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ppc-macos ppc64 sparc x86"
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
