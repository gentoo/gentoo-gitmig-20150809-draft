# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crypto++/crypto++-5.2-r1.ebuild,v 1.4 2004/12/07 06:11:28 dragonheart Exp $

inherit flag-o-matic eutils

DESCRIPTION="Crypto++ is a C++ class library of cryptographic schemes"
HOMEPAGE="http://cryptopp.com"
SRC_URI="mirror://sourceforge/cryptopp/crypto${PV//.}.zip"

LICENSE="cryptopp"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
DEPEND="app-arch/zip"
RDEPEND=""
IUSE=""

S=${WORKDIR}

src_compile() {
	# -O3 causes segfaults
	replace-flags -O3 -O2
	filter-flags -fomit-frame-pointer

	emake -f GNUmakefile CXXFLAGS="${CXXFLAGS}" || die
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
