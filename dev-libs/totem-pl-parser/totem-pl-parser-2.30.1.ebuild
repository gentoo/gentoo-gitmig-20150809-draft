# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/totem-pl-parser/totem-pl-parser-2.30.1.ebuild,v 1.7 2010/09/11 18:27:41 josejx Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="Playlist parsing library"
HOMEPAGE="http://www.gnome.org/projects/totem/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
# TODO: Re-generate doc ?
IUSE="doc introspection test"

RDEPEND=">=dev-libs/glib-2.24
	dev-libs/gmime:2.4"
DEPEND="${RDEPEND}
	!<media-video/totem-2.21
	>=dev-util/intltool-0.35
	>=dev-util/gtk-doc-am-1.11
	doc? ( >=dev-util/gtk-doc-1.11 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )"

DOCS="AUTHORS ChangeLog NEWS"

pkg_setup() {
	G2CONF="${G2CONF} --disable-static $(use_enable introspection)"
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check || die "emake check failed"
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libtotem-plparser-mini.so.12
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libtotem-plparser-mini.so.12
}
