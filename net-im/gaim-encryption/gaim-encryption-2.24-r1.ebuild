# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-encryption/gaim-encryption-2.24-r1.ebuild,v 1.3 2004/04/23 12:25:23 rizzo Exp $

inherit flag-o-matic

IUSE=""
DESCRIPTION="GAIM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~alpha ~ia64 ~hppa ~mips"

DEPEND=">=net-im/gaim-0.77
	|| ( dev-libs/nss net-www/mozilla )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/encrypt_api.diff
}

src_compile() {
	local myconf
	myconf="--with-gaim=/usr/include/gaim"

	NSS_LIB=/usr/lib
	NSS_INC=/usr/include
	has_version dev-libs/nss && {
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

pkg_postinst() {
	ewarn
	ewarn "This release is not backwards compatible for MSN, Yahoo, or IRC."
	ewarn "See the release notes at:"
	ewarn "https://sourceforge.net/project/shownotes.php?release_id=230104"
	ewarn
}
