# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crypto++/crypto++-5.5.2-r1.ebuild,v 1.2 2008/08/30 02:33:58 dragonheart Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Crypto++ is a C++ class library of cryptographic schemes"
HOMEPAGE="http://cryptopp.com"
SRC_URI="mirror://sourceforge/cryptopp/cryptopp${PV//.}.zip"

LICENSE="cryptopp"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
DEPEND="app-arch/unzip"
RDEPEND=""
IUSE="sse3"

S="${WORKDIR}"

src_compile() {
	# More than -O1 gives problems
	replace-flags -O? -O1
	filter-flags -fomit-frame-pointer
	use sse3 || append-flags -DCRYPTOPP_DISABLE_SSE2
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

	if ! ./cryptest.exe v; then
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
	dosym libcrypto++.a /usr/$(get_libdir)/libcryptopp.a
	insinto /usr/include/crypto++
	doins *.h
	# should the .exe extension be removed??
	dobin cryptest.exe
	# unbreak programs which expect cryptopp
	into /usr/include
	dosym crypto++ /usr/include/cryptopp
}
