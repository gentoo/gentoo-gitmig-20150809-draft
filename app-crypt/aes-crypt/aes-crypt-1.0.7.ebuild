# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/aes-crypt/aes-crypt-1.0.7.ebuild,v 1.1 2003/06/18 20:53:17 absinthe Exp $

At="${PN/-crypt/}-${PV}"
DESCRIPTION="Command line program ('aes') to encrypt and decrypt data using the Rjiandel algorythm"
HOMEPAGE="http://my.cubic.ch/users/timtas/aes/"
SRC_URI="http://my.cubic.ch/users/timtas/aes/${At}.tar.gz"
SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${At}.tar.gz
}

src_compile() {
	cd ${WORKDIR}/${At}
	sed -e "s:CFLAGS=-g -Wall:CFLAGS=-g -Wall ${CFLAGS}:" Makefile.linux > Makefile
	make || die
}

src_install() {
	cd ${WORKDIR}/${At}
	dobin aes
	dodoc CHANGES INSTALL LICENSE README TODO
}
