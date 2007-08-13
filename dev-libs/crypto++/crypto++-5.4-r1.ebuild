# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crypto++/crypto++-5.4-r1.ebuild,v 1.7 2007/08/13 20:21:21 dertobi123 Exp $

inherit flag-o-matic eutils toolchain-funcs

DESCRIPTION="Crypto++ is a C++ class library of cryptographic schemes"
HOMEPAGE="http://cryptopp.com"
SRC_URI="mirror://sourceforge/cryptopp/cryptopp${PV//.}.zip"

LICENSE="cryptopp"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86"
DEPEND="app-arch/unzip"
RDEPEND=""
IUSE=""

S="${WORKDIR}"

src_compile() {
	# -O3 causes segfaults
	replace-flags -O3 -O2
	filter-flags -fomit-frame-pointer
	emake -f GNUmakefile \
		CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" \
		AR="$(tc-getAR)" \
		RANLIB="$(tc-getRANLIB)" || die
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
