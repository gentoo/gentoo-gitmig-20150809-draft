# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-salut/telepathy-salut-0.3.8.ebuild,v 1.1 2009/04/18 20:58:31 eva Exp $

EAPI="2"

inherit base

DESCRIPTION="A link-local XMPP connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Components"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl test"

# FIXME: Automagic useless libasyncns check ?
RDEPEND="dev-libs/libxml2
	>=dev-libs/glib-2.16
	>=sys-apps/dbus-1.1.0
	>=dev-libs/dbus-glib-0.61
	>=net-libs/telepathy-glib-0.7.23
	>=net-dns/avahi-0.6.22
	net-libs/libsoup:2.4
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	test? (
		net-libs/libgsasl
		app-text/xmldiff
		>=dev-libs/check-0.9.4
		dev-python/twisted-words )
	dev-libs/libxslt
	>=dev-lang/python-2.4"

src_prepare() {
	base_src_prepare

	# Disable a failing test, upstream bug #21272
	sed 's#\(tcase_add_test (tc, test_tcp_listen);\)#/*\1*/#' \
		-i lib/gibber/tests/check-gibber-listener.c || die "sed failed"
}

src_configure() {
	econf $(use_enable ssl)
	# too much changes required: $(use_enable test avahi-tests)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}

