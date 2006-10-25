# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-encryption/gaim-encryption-3.0_beta6-r1.ebuild,v 1.1 2006/10/25 02:44:28 tester Exp $

inherit flag-o-matic debug eutils

MY_PV="${PV/_beta/beta}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GAIM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://gentoo/${PN}/${MY_P}.1.tar.gz
		http://dev.gentoo.org/~tester/dist/${MY_P}.1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

DEPEND=">=net-im/gaim-1.0.1
		>=dev-libs/nss-3.11"

src_compile() {
	strip-flags
	replace-flags -O? -O2
	econf \
		$(use_enable nls) || die "failed running configure"
	emake -j1 || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Install failed"
	dodoc CHANGELOG INSTALL NOTES README TODO VERSION WISHLIST
}
