# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/cvm/cvm-0.32.ebuild,v 1.1 2005/04/06 13:10:09 robbat2 Exp $

inherit fixheadtails toolchain-funcs

DESCRIPTION="CVM modules for unix and pwfile, plus testclient"
HOMEPAGE="http://untroubled.org/cvm/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
		>=dev-libs/bglibs-1.019"

src_unpack() {
	unpack ${A}
	cd ${S}
	ht_fix_file tests.sh Makefile
}

src_compile() {
	echo "/usr/lib/bglibs/include" > conf-bgincs
	echo "/usr/lib/bglibs/lib" > conf-bglibs
	echo "/usr" > conf-home
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC)" > conf-ld
	make || die
}

src_install() {
	dobin cvm-benchclient cvm-checkpassword cvm-pwfile cvm-testclient cvm-unix || die "dobin failed"

	insinto /usr/include/cvm
	doins *.h
	dosym /usr/include/cvm/sasl.h /usr/include/cvm-sasl.h

	for f in client udp local command module sasl; do
		newlib.a ${f}.a libcvm-${f}.a || die "newlib.a ${f}.a failed"
	done

	dodoc ANNOUNCEMENT FILES NEWS README TARGETS TODO VERSION
	dohtml *.html
}
