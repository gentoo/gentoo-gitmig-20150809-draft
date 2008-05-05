# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-gabble/telepathy-gabble-0.7.5.ebuild,v 1.1 2008/05/05 15:06:13 coldwind Exp $

inherit eutils

DESCRIPTION="A Jabber/XMPP connection manager, this handles single and multi user chats and voice calls."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

RDEPEND=">=dev-libs/glib-2.4
	>=dev-libs/dbus-glib-0.72
	>=net-libs/telepathy-glib-0.7.0
	dev-lang/python
	>=net-libs/loudmouth-1.3.2"

DEPEND="${RDEPEND}
	dev-libs/libxslt
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
	if ! dbus-launch emake -j1 check; then
		die "Make check failed. See above for details."
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS NEWS ChangeLog
}
