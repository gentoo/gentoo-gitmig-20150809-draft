# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/polarssl/polarssl-0.12.0.ebuild,v 1.5 2010/07/11 15:13:06 jer Exp $

inherit eutils

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="http://polarssl.org/"
SRC_URI="http://polarssl.org/code/download/${P}-gpl.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="examples sse2"

src_compile() {
	cd "${S}/library"
	if use sse2 ; then
		sed -i '15iCFLAGS += -DHAVE_SSE2 -fPIC' Makefile
	else
		sed -i '15iCFLAGS += -fPIC' Makefile
	fi
	epatch "${FILESDIR}"/${P}-makefile.patch
	emake libpolarssl.so || die "emake failed"

	if use examples ; then
		cd "${S}"/programs
		emake all || die "emake failed"
	fi
}

src_test() {
	cd "${S}"/programs
	emake test/selftest || die "emake selftest failed"
	LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:../library" ./test/selftest || die "selftest failed"
}

src_install() {
	insinto /usr/include/polarssl
	doins include/polarssl/*.h || die
	dolib.so library/libpolarssl.so || die
	dolib.a library/libpolarssl.a || die

	if use examples ; then
		for p in programs/*/* ; do
			if [[ -x "${p}" && ! -d "${p}" ]] ; then
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
