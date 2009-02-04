# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-glib/telepathy-glib-0.7.25.ebuild,v 1.1 2009/02/04 19:52:10 tester Exp $

DESCRIPTION="GLib bindings for the Telepathy D-Bus protocol."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="debug doc"

RDEPEND=">=dev-libs/glib-2.16
	>=dev-libs/dbus-glib-0.73
	>=dev-lang/python-2.3"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-util/pkgconfig-0.21
	doc? ( >=dev-util/gtk-doc-1.10 )"

src_compile() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_enable debug) \
		$(use_enable debug backtrace) \
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
	dodoc AUTHORS ChangeLog NEWS README
}
