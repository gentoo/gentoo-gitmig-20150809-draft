# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-encryption/gaim-encryption-2.32.ebuild,v 1.1 2004/10/16 23:01:55 rizzo Exp $

inherit flag-o-matic eutils debug

DESCRIPTION="GAIM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64"
IUSE=""
RESTRICT="nomirror"

DEPEND=">=net-im/gaim-1.0.1
		dev-libs/nss"

src_compile() {
	local myconf

	NSS_LIB=/usr/lib
	NSS_INC=/usr/include
	myconf="${myconf} --with-nspr-includes=${NSS_INC}/nspr"
	myconf="${myconf} --with-nss-includes=${NSS_INC}/nss"
	myconf="${myconf} --with-nspr-libs=${NSS_LIB}"
	myconf="${myconf} --with-nss-libs=${NSS_LIB}"

	econf ${myconf} || die "Configuration failed"
	einfo "Replacing -Os CFLAG with -O2"
	replace-flags -Os -O2

	emake || emake -j1 || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc CHANGELOG INSTALL NOTES README TODO VERSION WISHLIST
}
