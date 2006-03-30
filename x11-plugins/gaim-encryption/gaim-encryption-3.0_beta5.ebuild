# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-encryption/gaim-encryption-3.0_beta5.ebuild,v 1.1 2006/03/30 16:37:26 gothgirl Exp $

inherit flag-o-matic debug eutils

MY_PV="${PV/_beta/beta}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GAIM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=net-im/gaim-1.0.1
		>=dev-libs/nss-3.11"

src_compile() {
	strip-flags
	replace-flags -O? -O2
	econf || die "failed running configure"
	emake -j1 || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Install failed"
	dodoc CHANGELOG INSTALL NOTES README TODO VERSION WISHLIST
}
