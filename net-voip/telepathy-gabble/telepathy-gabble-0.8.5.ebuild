# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-gabble/telepathy-gabble-0.8.5.ebuild,v 1.1 2009/10/05 19:52:24 tester Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A Jabber/XMPP connection manager, this handles single and multi user chats and voice calls."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="debug test"

RDEPEND=">=dev-libs/glib-2.16
	>=sys-apps/dbus-1.1.0
	>=dev-libs/dbus-glib-0.78
	>=net-libs/telepathy-glib-0.7.34
	>=net-libs/loudmouth-1.3.2[ssl]
	net-libs/libsoup:2.4[ssl]"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-lang/python-2.5
	test? ( >=dev-python/twisted-0.8.2
		>=dev-python/twisted-words-0.8.2
		>=dev-python/dbus-python-0.83 )"

# 2 tests still fail :-(
RESTRICT="test"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable debug) \
		$(use_enable debug handle-leak-debug)
}

src_test() {
	emake -j1 check || die "Make check failed. See above for details."
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS NEWS ChangeLog README || die "dodoc failed"
}
