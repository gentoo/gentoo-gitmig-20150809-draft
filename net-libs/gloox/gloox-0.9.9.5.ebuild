# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gloox/gloox-0.9.9.5.ebuild,v 1.2 2009/01/31 21:33:45 jokey Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="A portable high-level Jabber/XMPP library for C++"
HOMEPAGE="http://camaya.net/gloox"
SRC_URI="http://camaya.net/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gnutls idn ssl zlib"

DEPEND="idn? ( >=net-dns/libidn-0.5.0 )
	gnutls? ( >=net-libs/gnutls-1.2.0 )
	ssl? ( >=dev-libs/openssl-0.9.8 )
	zlib? ( >=sys-libs/zlib-1.2.3 )"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_configure() {
	econf \
		$(use_enable debug debug) \
		$(use_with idn libidn) \
		$(use_with gnutls gnutls) \
		$(use_with ssl openssl) \
		$(use_with zlib zlib) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
