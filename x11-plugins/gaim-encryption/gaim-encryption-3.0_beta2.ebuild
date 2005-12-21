# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-encryption/gaim-encryption-3.0_beta2.ebuild,v 1.1 2005/12/21 16:54:52 gothgirl Exp $

inherit flag-o-matic debug multilib

MY_PV="${PV/_beta/beta}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GAIM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-im/gaim-1.0.1
		>=dev-libs/nss-3.9.2-r2"

src_unpack() {
	unpack ${A}
	cd ${S}
}

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
