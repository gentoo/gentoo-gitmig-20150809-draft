# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/conspire/conspire-1.0.1.ebuild,v 1.3 2011/02/05 17:40:34 ssuominen Exp $

EAPI=2
inherit eutils

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A high quality IRC client which uses a multitude of interfaces"
HOMEPAGE="http://www.nenolod.net/conspire/"
SRC_URI="http://distfiles.atheme.org/${MY_P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
# Enable gnutls by default until bug 339204 is solved.
IUSE="python +gnutls ipv6 nls mmx socks5 dbus"

RDEPEND=">=dev-libs/libmowgli-0.6.0
	>=x11-libs/gtk+-2.10:2
	>=dev-libs/glib-2.14
	x11-libs/libnotify
	x11-libs/libsexy
	dbus? ( >=dev-libs/dbus-glib-0.88 )
	gnutls? ( net-libs/gnutls )
	python? ( >=dev-lang/python-2.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
}

src_configure() {
	econf \
		$(use_enable socks5 socks) \
		$(use_enable ipv6) \
		$(use_enable gnutls) \
		$(use_enable python) \
		$(use_enable mmx) \
		$(use_enable nls) \
		$(use_enable dbus) \
		--enable-spell=libsexy \
		--enable-regex
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS TODO
}
