# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/telepathy-glib/telepathy-glib-0.12.0.ebuild,v 1.1 2010/09/29 11:29:52 pacho Exp $

EAPI="2"

DESCRIPTION="GLib bindings for the Telepathy D-Bus protocol."
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug introspection"

RDEPEND=">=dev-libs/glib-2.24
	>=dev-libs/dbus-glib-0.82
	>=dev-lang/python-2.5
	introspection? ( >=dev-libs/gobject-introspection-0.6.14 )"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-util/pkgconfig-0.21"

src_configure() {
	# configure help says vala-bindings are experimental
	econf \
		$(use_enable debug) \
		$(use_enable debug backtrace) \
		$(use_enable debug handle-leak-debug) \
		$(use_enable introspection) \
		--disable-vala-bindings
}

src_test() {
	if ! dbus-launch emake -j1 check; then
		die "Make check failed. See above for details."
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
