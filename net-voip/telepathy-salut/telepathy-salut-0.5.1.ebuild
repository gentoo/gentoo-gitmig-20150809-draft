# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-salut/telepathy-salut-0.5.1.ebuild,v 1.5 2011/10/21 15:03:10 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"

inherit base python eutils

DESCRIPTION="A link-local XMPP connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Components"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~sparc x86 ~x86-linux"
IUSE="test"

RDEPEND="dev-libs/libxml2
	>=dev-libs/glib-2.24:2
	>=sys-apps/dbus-1.1.0
	>=net-libs/telepathy-glib-0.13.12
	>=net-dns/avahi-0.6.22[dbus]
	net-libs/libsoup:2.4
	sys-apps/util-linux"
DEPEND="${RDEPEND}
	app-text/xmldiff
	test? (
		>=dev-libs/check-0.9.4
		net-libs/libgsasl
		dev-python/twisted-words )
	dev-libs/libxslt
	dev-util/pkgconfig"
# FIXME: needs xmppstream python module
#		>=net-dns/avahi-0.6.22[python]

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	python_set_active_version 2
}

src_prepare() {
	# Fix uninitialized variable, upstream bug #37701
	epatch "${FILESDIR}/${PN}-0.5.0-uninitialized.patch"

	python_convert_shebangs -r 2 .
}

src_configure() {
	econf \
		--disable-plugins \
		--disable-Werror
		#--docdir=/usr/share/doc/${PF}
		#$(use_enable test avahi-tests)
}
