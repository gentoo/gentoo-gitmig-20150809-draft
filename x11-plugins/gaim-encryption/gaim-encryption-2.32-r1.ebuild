# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-encryption/gaim-encryption-2.32-r1.ebuild,v 1.1 2004/11/27 02:07:26 rizzo Exp $

inherit flag-o-matic eutils debug

DESCRIPTION="GAIM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~ppc64"
IUSE=""

DEPEND=">=net-im/gaim-1.0.1
	>=dev-libs/nspr-4.4.1-r2
	dev-libs/nss"

src_compile() {
	local myconf

	NSS_LIB=/usr/lib
	NSS_INC=/usr/include
	myconf="${myconf} --with-nspr-includes=${NSS_INC}/nspr"
	myconf="${myconf} --with-nss-includes=${NSS_INC}/nss"
	myconf="${myconf} --with-nspr-libs=${NSS_LIB}/nspr"
	myconf="${myconf} --with-nss-libs=${NSS_LIB}/nss"

	econf ${myconf} || die "Configuration failed"
	einfo "Replacing -Os CFLAG with -O2"
	replace-flags -Os -O2

	emake || emake -j1 || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc CHANGELOG INSTALL NOTES README TODO VERSION WISHLIST
}
