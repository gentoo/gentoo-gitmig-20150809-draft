# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gloox/gloox-1.0_beta2.ebuild,v 1.1 2008/04/21 19:40:04 jokey Exp $

inherit autotools

DESCRIPTION="A portable high-level Jabber/XMPP library for C++"
HOMEPAGE="http://camaya.net/gloox"
SRC_URI="http://camaya.net/download/${PN}-1.0-beta2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gnutls idn ssl zlib"

DEPEND="idn? ( net-dns/libidn )
	gnutls? ( net-libs/gnutls )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-1.0-beta2

src_compile() {
	econf \
		$(use_enable debug debug) \
		$(use_with idn libidn) \
		$(use_with gnutls gnutls) \
		$(use_with ssl openssl) \
		$(use_with zlib zlib) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
