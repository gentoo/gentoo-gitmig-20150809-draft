# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ttyrec/ttyrec-1.0.6.ebuild,v 1.1 2003/09/10 16:31:17 usata Exp $

DESCRIPTION="tty recorder"
HOMEPAGE="http://namazu.org/~satoru/ttyrec/"
SRC_URI="http://namazu.org/~satoru/ttyrec/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND="virtual/glibc"

S=${WORKDIR}/${P}

src_compile () {
	make CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin ttyrec ttyplay ttytime
	dodoc README
}
