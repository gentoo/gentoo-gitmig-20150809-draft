# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libf2c/libf2c-20021004.ebuild,v 1.13 2005/01/10 19:55:03 corsair Exp $

inherit gcc

DESCRIPTION="Library that converts FORTRAN to C source."
HOMEPAGE="ftp://ftp.netlib.org/f2c/index.html"
SRC_URI="ftp://ftp.netlib.org/f2c/${PN}.zip"

LICENSE="libf2c"
SLOT="0"
KEYWORDS="x86 -amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	emake -f makefile.u \
		CFLAGS="${CFLAGS}" \
		CC="$(gcc-getCC)" \
		|| die
}

src_install () {
	dolib.a libf2c.a
	insinto /usr/include
	doins f2c.h
	dodoc README Notice
}
