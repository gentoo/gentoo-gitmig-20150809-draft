# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libf2c/libf2c-20021004.ebuild,v 1.7 2004/03/14 12:28:57 mr_bones_ Exp $

inherit gcc

DESCRIPTION="Library that converts FORTRAN to C source."
HOMEPAGE="ftp://ftp.netlib.org/f2c/index.html"
SRC_URI="ftp://ftp.netlib.org/f2c/${PN}.zip"

LICENSE="libf2c"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc"

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
