# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mpack/mpack-1.5.ebuild,v 1.4 2002/10/20 18:52:11 vapier Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Command-line MIME encoding and decoding utilities"
HOMEPAGE="ftp://ftp.andrew.cmu.edu/pub/mpack/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/mpack/${P}-src.tar.Z"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"


src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dodir /usr
	make DESTDIR=${D}/usr install || die
}
