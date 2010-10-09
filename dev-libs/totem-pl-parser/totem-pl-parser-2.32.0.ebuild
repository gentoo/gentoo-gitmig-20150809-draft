# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/totem-pl-parser/totem-pl-parser-2.32.0.ebuild,v 1.1 2010/10/09 20:48:13 pacho Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Playlist parsing library"
HOMEPAGE="http://www.gnome.org/projects/totem/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc +introspection"

RDEPEND=">=dev-libs/glib-2.24
	dev-libs/gmime:2.4
	>=net-libs/libsoup-gnome-2.30:2.4"
DEPEND="${RDEPEND}
	!<media-video/totem-2.21
	>=dev-util/intltool-0.35
	>=dev-util/gtk-doc-am-1.11
	doc? ( >=dev-util/gtk-doc-1.11 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.14 )"

pkg_setup() {
	G2CONF="${G2CONF} --disable-static $(use_enable introspection)"
	DOCS="AUTHORS ChangeLog NEWS"
}

src_test() {
	# This is required as told by upstream in bgo#629542
	dbus-launch emake check || die "make check failed"
}
