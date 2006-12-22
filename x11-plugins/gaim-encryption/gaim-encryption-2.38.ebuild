# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-encryption/gaim-encryption-2.38.ebuild,v 1.12 2006/12/22 18:39:05 gothgirl Exp $

inherit flag-o-matic debug multilib

DESCRIPTION="GAIM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-util/pkgconfig
	>=net-im/gaim-1.0.1
	>=dev-libs/nss-3.9.2-r2"

src_compile() {
	strip-flags
	replace-flags -O? -O2

	econf \
		--with-nspr-includes=/usr/include/nspr \
		--with-nss-includes=/usr/include/nss \
		--with-nspr-libs=/usr/$(get_libdir)/nspr \
		--with-nss-libs=/usr/$(get_libdir)/nss\
		|| die "Configuration failed"
	emake -j1 || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Install failed"
	dodoc CHANGELOG INSTALL NOTES README TODO VERSION WISHLIST
}
