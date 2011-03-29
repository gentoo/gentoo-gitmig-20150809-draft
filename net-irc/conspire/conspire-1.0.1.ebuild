# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/conspire/conspire-1.0.1.ebuild,v 1.6 2011/03/29 15:08:52 angelos Exp $

EAPI=3
PYTHON_DEPEND="python? 2:2.6"
inherit eutils python

MY_P=${P/_/-}

DESCRIPTION="A high quality IRC client which uses a multitude of interfaces"
HOMEPAGE="http://www.nenolod.net/conspire/"
SRC_URI="http://distfiles.atheme.org/${MY_P}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~sparc ~x86"
IUSE="dbus ipv6 mmx nls python socks5"

RDEPEND=">=dev-libs/glib-2.14:2
	>=dev-libs/libmowgli-0.6.0
	net-libs/gnutls
	>=x11-libs/gtk+-2.10:2
	>=x11-libs/libnotify-0.4.5
	x11-libs/libsexy
	dbus? ( >=dev-libs/dbus-glib-0.88 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable socks5 socks) \
		$(use_enable ipv6) \
		--enable-gnutls \
		$(use_enable python) \
		$(use_enable mmx) \
		--enable-spell=libsexy \
		--enable-regex \
		$(use_enable dbus)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS TODO
}
