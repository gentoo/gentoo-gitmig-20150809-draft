# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-gabble/telepathy-gabble-0.4.8.ebuild,v 1.1 2006/11/30 22:29:23 peper Exp $

DESCRIPTION="A Jabber/XMPP connection manager, this handles single and multi user chats and voice calls."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug loudmouth"

DEPEND=">=dev-libs/glib-2.4
	|| ( >=dev-libs/dbus-glib-0.71
		( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.61 ) )
	loudmouth? ( >=net-libs/loudmouth-1.1.1 )"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable debug backtrace) \
		$(use_enable debug handle-leak-debug) \
		$(use_enable loudmouth) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_test() {
	vecho ">>> Test phase [check]: ${CATEGORY}/${PF}"
	if ! dbus-launch emake -j1 check; then
		hasq test $FEATURES && die "Make check failed. See above for details."
		hasq test $FEATURES || eerror "Make check failed.  See above for details."
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog
}

pkg_postinst() {
	elog "You don't need to start telepathy-gabble manualy any more."
	elog "dbus will take care of that."
}
