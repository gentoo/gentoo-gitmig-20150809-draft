# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/crypto++/crypto++-5.1.ebuild,v 1.1 2003/11/25 00:30:38 rphillips Exp $

DESCRIPTION="Crypto++ is a C++ class library of cryptographic schemes"
HOMEPAGE="http://cryptopp.com"
SRC_URI="mirror://sourceforge/cryptopp/crypto${PV//.}.zip"

LICENSE="cryptopp"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
#RDEPEND=""

S=${WORKDIR}

src_compile() {
	emake -f GNUmakefile CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	# For consistency across GNU/Linux distributions,
	# "crypto++" has been preferred over "crytopp"
	newlib.a libcryptopp.a libcrypto++.a
	insinto /usr/include/crypto++
	doins *.h
}
