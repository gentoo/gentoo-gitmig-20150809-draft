# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libf2c/libf2c-20021004.ebuild,v 1.5 2003/08/06 08:07:16 vapier Exp $

IUSE=""
S="${WORKDIR}/${PN}"
DESCRIPTION="Library that converts FORTRAN to C source."
SRC_URI="ftp://ftp.netlib.org/f2c/${PN}.zip"
HOMEPAGE="ftp://ftp.netlib.org/f2c/index.html"
LICENSE="libf2c"
KEYWORDS="x86"
SLOT="0"
DEPEND="virtual/glibc"

src_compile() {
	sed -e "s:CFLAGS = -O::" makefile.u > makefile || \
		die "sed makefile failed"
	emake || die
}

src_install () {
	into /usr
	dolib.a libf2c.a
	insinto /usr/include
	doins f2c.h
	dodoc README Notice
}
