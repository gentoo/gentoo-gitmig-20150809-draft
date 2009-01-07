# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-gabble/telepathy-gabble-0.7.17.ebuild,v 1.2 2009/01/07 17:09:53 armin76 Exp $

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
	>=net-libs/telepathy-glib-0.7.18
	>=net-libs/loudmouth-1.3.2"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-lang/python
	test? ( dev-python/twisted
		dev-python/twisted-words )"

pkg_setup() {
	if ! built_with_use -o net-libs/loudmouth ssl gnutls ; then
		eerror "${PN} needs net-libs/loudmouth built with"
		eerror "USE='gnutls' or USE='ssl'."
		die "No TLS support in net-libs/loudmouth"
	fi
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable debug handle-leak-debug) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	emake -j1 check || die "Make check failed. See above for details."
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS NEWS ChangeLog
}
