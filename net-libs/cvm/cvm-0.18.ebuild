# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/cvm/cvm-0.18.ebuild,v 1.1 2004/01/06 00:07:56 robbat2 Exp $

inherit fixheadtails

S=${WORKDIR}/${P}
DESCRIPTION="CVM modules for unix and pwfile, plus testclient"
SRC_URI="http://untroubled.org/cvm/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/cvm"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
DEPEND="virtual/glibc
	>=dev-libs/bglibs-1.009"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	ht_fix_file tests.sh Makefile
}

src_compile() {
	cd ${S}
	echo "/usr/lib/bglibs/include" > conf-bgincs
	echo "/usr/lib/bglibs/lib" > conf-bglibs
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} -s" > conf-ld
	make || die
}

src_install () {
	into /usr
	dobin cvm-benchclient cvm-checkpassword cvm-pwfile cvm-testclient cvm-unix

	insinto /usr/include/cvm
	doins *.h

	newlib.a client.a libcvm-client.a
	newlib.a udp.a libcvm-udp.a
	newlib.a local.a libcvm-local.a
	newlib.a command.a libcvm-command.a
	newlib.a module.a libcvm-module.a
	newlib.a sasl.a libcvm-sasl.a

	dosym /usr/include/cvm/sasl.h /usr/include/cvm-sasl.h

	dodoc ANNOUNCEMENT COPYING FILES NEWS README TARGETS TODO VERSION
	dohtml *.html
}
