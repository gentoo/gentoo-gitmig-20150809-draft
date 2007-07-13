# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/xyssl/xyssl-0.7.ebuild,v 1.1 2007/07/13 18:31:09 pylon Exp $

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="http://xyssl.org/"
SRC_URI="http://xyssl.org/code/download/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="examples sse2"

DEPEND="virtual/libc"

src_compile() {
	cd "${S}/library"
	if use sse2 ; then
		sed -i '15iCFLAGS += -DHAVE_SSE2 -fPIC' Makefile
	else
		sed -i '15iCFLAGS += -fPIC' Makefile
	fi
	emake libxyssl.a || die "emake failed"
	emake libxyssl.so || die "emake failed"

	if use examples ; then
		cd "${S}/programs"
		emake all
	fi
}

src_test() {
	cd "${S}/programs"
	emake test/selftest
	./test/selftest || die "selftest failed"
}

src_install() {
	dodir /usr/include/xyssl
	insinto /usr/include/xyssl
	doins include/xyssl/*.h
	dolib.so library/libxyssl.so
	dolib.a library/libxyssl.a

	if use examples ; then
		for p in programs/*/* ; do
			if [ -x ${p} ] ; then
				f=xyssl_`basename ${p}`
				newbin ${p} ${f}
			fi
		done
		for e in aes hash pkey ssl test ; do
			docinto ${e}
			dodoc programs/${e}/*.c
			dodoc programs/${e}/*.txt
		done
	fi
}
