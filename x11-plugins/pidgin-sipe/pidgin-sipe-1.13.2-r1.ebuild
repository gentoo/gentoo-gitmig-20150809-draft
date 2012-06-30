# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-sipe/pidgin-sipe-1.13.2-r1.ebuild,v 1.1 2012/06/30 22:00:30 thev00d00 Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Pidgin Plug-in SIPE (Sip Exchange Protocol)"
HOMEPAGE="http://sipe.sourceforge.net/"
SRC_URI="mirror://sourceforge/sipe/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kerberos ocs2005-message-hack voice"

RDEPEND="net-im/pidgin[gnutls]
	>=dev-libs/gmime-2.4.16
	dev-libs/libxml2
	kerberos? ( virtual/krb5 )
	voice? (
		>=dev-libs/glib-2.28.0
		>=net-libs/libnice-0.1.0
		media-libs/gstreamer
		>=net-im/pidgin-2.8.0[gnutls]
	)
	!voice? (
		>=dev-libs/glib-2.12.0
		net-im/pidgin[gnutls]
	)
"

DEPEND="dev-util/intltool
	virtual/pkgconfig
	${RDEPEND}
"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-sandbox-r1.patch"
	eautoreconf
}

src_configure() {
	econf \
		--enable-purple \
		--disable-quality-check \
		--disable-telepathy \
		$(use_enable debug) \
		$(use_enable ocs2005-message-hack) \
		$(use_with kerberos krb5) \
		$(use_with voice vv)
}

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS ChangeLog NEWS TODO README
}
