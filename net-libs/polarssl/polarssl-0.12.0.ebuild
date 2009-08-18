# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/polarssl/polarssl-0.12.0.ebuild,v 1.1 2009/08/18 12:34:06 tommy Exp $

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="http://polarssl.org/"
SRC_URI="http://polarssl.org/code/download/${P}-gpl.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="examples sse2"

DEPEND="virtual/libc"
RDEPEND=${DEPEND}

src_compile() {
	cd "${S}/library"
	if use sse2 ; then
		sed -i '15iCFLAGS += -DHAVE_SSE2 -fPIC' Makefile
	else
		sed -i '15iCFLAGS += -fPIC' Makefile
	fi
	emake libpolarssl.a || die "emake failed"
	emake libpolarssl.so || die "emake failed"

	if use examples ; then
		cd "${S}"/programs
		emake all || die "emake failed"
	fi
}

src_test() {
	cd "${S}"/programs
	emake test/selftest || die "emake selftest failed"
	./test/selftest || die "selftest failed"
}

src_install() {
	insinto /usr/include/polarssl
	doins include/polarssl/*.h || die
	dolib.so library/libpolarssl.so || die
	dolib.a library/libpolarssl.a || die

	if use examples ; then
		for p in programs/*/* ; do
			if [ -x "${p}" ] ; then
				f=polarssl_`basename "${p}"`
				newbin "${p}" "${f}" || die
			fi
		done
		for e in aes hash pkey ssl test ; do
			docinto "${e}"
			dodoc programs/"${e}"/*.c || die
			dodoc programs/"${e}"/*.txt || die
		done
	fi
}
