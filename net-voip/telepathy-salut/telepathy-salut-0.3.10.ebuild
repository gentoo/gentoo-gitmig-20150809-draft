# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-salut/telepathy-salut-0.3.10.ebuild,v 1.9 2010/08/07 16:55:31 armin76 Exp $

EAPI="2"

inherit base

DESCRIPTION="A link-local XMPP connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Components"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="ssl test"

# FIXME: Automagic useless libasyncns check ?
RDEPEND="dev-libs/libxml2
	>=dev-libs/glib-2.16
	>=sys-apps/dbus-1.1.0
	>=dev-libs/dbus-glib-0.61
	>=net-libs/telepathy-glib-0.7.36
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

src_configure() {
	econf $(use_enable ssl) --docdir=/usr/share/doc/${PF}
	# too much changes required: $(use_enable test avahi-tests)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
