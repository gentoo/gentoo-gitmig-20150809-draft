# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-encryption/gaim-encryption-2.21.ebuild,v 1.3 2004/01/27 21:42:43 rizzo Exp $

IUSE="mozilla"

DESCRIPTION="GAIM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~amd64 ppc"

DEPEND=">=net-im/gaim-0.75-r3
	mozilla? ( net-www/mozilla )
	!mozilla? ( dev-libs/nss )"

src_compile() {

	local myconf
	myconf="--with-gaim=/usr/include/gaim"

	NSS_LIB=/usr/lib
	NSS_INC=/usr/include
	use mozilla || {
		# Only need to specify this if no pkgconfig from mozilla
		myconf="${myconf} --with-nspr-includes=${NSS_INC}/nspr"
		myconf="${myconf} --with-nss-includes=${NSS_INC}/nss"
		myconf="${myconf} --with-nspr-libs=${NSS_LIB}"
		myconf="${myconf} --with-nss-libs=${NSS_LIB}"
	}

	econf ${myconf} || die "Configuration failed"
	einfo "Replacing -Os CFLAG with -O2"
	replace-flags -Os -O2

	emake || MAKEOPTS="${MAKEOPTS} -j1" emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc CHANGELOG COPYING INSTALL NOTES README TODO VERSION WISHLIST
}
