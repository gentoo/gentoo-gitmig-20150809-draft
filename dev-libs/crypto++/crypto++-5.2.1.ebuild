# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crypto++/crypto++-5.2.1.ebuild,v 1.15 2007/07/12 02:25:34 mr_bones_ Exp $

inherit flag-o-matic eutils

DESCRIPTION="Crypto++ is a C++ class library of cryptographic schemes"
HOMEPAGE="http://cryptopp.com"
SRC_URI="mirror://sourceforge/cryptopp/cryptopp${PV//.}.zip"

LICENSE="cryptopp"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
DEPEND="app-arch/unzip"
RDEPEND=""
IUSE=""

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	# bug 117547 - gcc4
	epatch "${FILESDIR}"/${PN}-5.2.1-ubuntu-gcc4.patch
}

src_compile() {
	# -O3 causes segfaults
	replace-flags -O3 -O2
	filter-flags -fomit-frame-pointer
	filter-flags -msse2
	if use x86 || use amd64
	then
		append-flags -mno-sse2
	fi
	emake -f GNUmakefile || die
}

src_test() {
	# make sure all test vectors have unix line endings
	for f in TestVectors/* ; do
		edos2unix $f
	done

	if ! ./cryptest.exe v
	then
	    eerror "crypto++ self-tests failed"
	    eerror "Try to remove some optimization flags and re-emerge"
	    die
	fi;
}

src_install() {
	# For consistency across GNU/Linux distributions,
	# "crypto++" has been preferred over "crytopp"...
	newlib.a libcryptopp.a libcrypto++.a
	# ...unbreak programs which don't expect this
	dosym libcrypto++.a /usr/lib/libcryptopp.a
	insinto /usr/include/crypto++
	doins *.h
	# should the .exe extension be removed??
	dobin cryptest.exe
	# unbreak programs which expect cryptopp
	into /usr/include
	dosym crypto++ /usr/include/cryptopp
}
