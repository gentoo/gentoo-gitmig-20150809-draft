# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/aes-crypt/aes-crypt-1.0.7.ebuild,v 1.8 2004/08/08 13:14:00 mcummings Exp $

MY_P="${PN/-crypt/}-${PV}"
DESCRIPTION="Command line program ('aes') to encrypt and decrypt data using the Rijndael algorithm"
HOMEPAGE="http://my.cubic.ch/users/timtas/aes/"
SRC_URI="http://my.cubic.ch/users/timtas/aes/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:CFLAGS=-g -Wall:CFLAGS=-g -Wall ${CFLAGS}:" Makefile.linux > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin aes || die
	dodoc CHANGES INSTALL README TODO
}
