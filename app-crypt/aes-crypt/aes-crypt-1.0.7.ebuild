# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/aes-crypt/aes-crypt-1.0.7.ebuild,v 1.4 2004/03/13 21:50:28 mr_bones_ Exp $

At="${PN/-crypt/}-${PV}"
DESCRIPTION="Command line program ('aes') to encrypt and decrypt data using the Rijndael algorythm"
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
