# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-encryption/pidgin-encryption-3.0.ebuild,v 1.6 2007/08/26 12:36:21 philantrop Exp $

inherit flag-o-matic eutils

DESCRIPTION="Pidgin IM Encryption PlugIn"
HOMEPAGE="http://gaim-encryption.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaim-encryption/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="nls"

RDEPEND="net-im/pidgin
	>=x11-libs/gtk+-2
	>=dev-libs/nss-3.11"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	strip-flags
	replace-flags -O? -O2
	econf $(use_enable nls) || die "failed running configure"
	emake -j1 || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Install failed"
	dodoc CHANGELOG INSTALL NOTES README TODO VERSION WISHLIST
}
