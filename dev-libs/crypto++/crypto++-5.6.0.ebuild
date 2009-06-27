# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crypto++/crypto++-5.6.0.ebuild,v 1.1 2009/06/27 20:09:40 arfrever Exp $

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="Crypto++ is a C++ class library of cryptographic schemes"
HOMEPAGE="http://cryptopp.com"
SRC_URI="mirror://sourceforge/cryptopp/cryptopp${PV//.}.zip"

LICENSE="cryptopp"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
DEPEND="app-arch/unzip"
RDEPEND=""
IUSE="sse3"

S="${WORKDIR}"

src_compile() {
	# More than -O1 gives problems.
	replace-flags -O? -O1
	filter-flags -fomit-frame-pointer
	use sse3 || append-flags -DCRYPTOPP_DISABLE_SSE2
	emake -f GNUmakefile \
		CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" \
		AR="$(tc-getAR)" \
		RANLIB="$(tc-getRANLIB)" || die "emake failed"
}

src_test() {
	# Make sure all test vectors have unix line endings.
	for file in TestVectors/*; do
		edos2unix ${file}
	done

	if ! ./cryptest.exe v; then
	    eerror "crypto++ self-tests failed"
	    eerror "Try to remove some optimization flags and re-emerge"
	    die
	fi;
}

src_install() {
	# For consistency across GNU/Linux distributions,
	# "crypto++" has been preferred over "cryptopp"...
	newlib.a libcryptopp.a libcrypto++.a
	# ...unbreak programs which don't expect this
	dosym libcrypto++.a /usr/$(get_libdir)/libcryptopp.a
	insinto /usr/include/crypto++
	doins *.h
	newbin cryptest.exe cryptest
	# Unbreak programs which expect cryptopp
	into /usr/include
	dosym crypto++ /usr/include/cryptopp
}
