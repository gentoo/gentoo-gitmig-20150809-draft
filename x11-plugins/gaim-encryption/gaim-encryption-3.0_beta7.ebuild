# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-encryption/gaim-encryption-3.0_beta7.ebuild,v 1.7 2007/03/23 21:10:43 drizzt Exp $

inherit flag-o-matic eutils

MY_PV="${PV/_beta/beta}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GAIM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://gentoo/${PN}/${MY_P}.tar.gz
		http://dev.gentoo.org/~gothgirl/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

DEPEND="dev-util/pkgconfig
	>=net-im/gaim-2.0_beta1
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
