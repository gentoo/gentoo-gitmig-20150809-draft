# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-gabble/telepathy-gabble-0.10.4.ebuild,v 1.1 2010/11/03 21:09:25 ford_prefect Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A Jabber/XMPP connection manager, this handles single and multi user chats and voice calls."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug test"

RDEPEND=">=dev-libs/glib-2.24
	>=sys-apps/dbus-1.1.0
	>=dev-libs/dbus-glib-0.82
	>=net-libs/telepathy-glib-0.11.16
	net-libs/libsoup:2.4[ssl]
	>=net-libs/libnice-0.0.11
	>=net-libs/gnutls-2.10.2
	dev-db/sqlite:3
	dev-libs/libxml2
	!<net-im/telepathy-mission-control-5.5.0"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-lang/python-2.5
	test? ( >=dev-python/twisted-0.8.2
		>=dev-python/twisted-words-0.8.2
		>=dev-python/dbus-python-0.83 )"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable debug handle-leak-debug)
}

src_test() {
	# Twisted tests fail, upstream bug #30565
	emake -C tests check-TESTS || die "tests failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS NEWS ChangeLog README || die "dodoc failed"
}
