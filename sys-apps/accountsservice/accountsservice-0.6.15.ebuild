# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/accountsservice/accountsservice-0.6.15.ebuild,v 1.3 2012/04/25 21:04:08 maekke Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 systemd

DESCRIPTION="D-Bus interfaces for querying and manipulating user account information"
HOMEPAGE="http://www.fedoraproject.org/wiki/Features/UserAccountDialog"
SRC_URI="http://www.freedesktop.org/software/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm ~x86"
IUSE="doc +introspection"

RDEPEND="dev-libs/glib:2
	dev-libs/dbus-glib
	sys-auth/polkit
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.40
	doc? (
		app-text/docbook-xml-dtd:4.1.2
		app-text/xmlto )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--disable-more-warnings
		--localstatedir=${EPREFIX}/var
		--docdir=${EPREFIX}/usr/share/doc/${PF}
		$(use_enable doc docbook-docs)
		$(use_enable introspection)
		$(systemd_with_unitdir)"
	DOCS="AUTHORS NEWS README TODO"
}
