# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goffice/goffice-0.2.1.ebuild,v 1.7 2006/09/05 20:51:30 tcort Exp $

inherit eutils gnome2 flag-o-matic

DESCRIPTION="A library of document-centric objects and utilities"
HOMEPAGE="http://freshmeat.net/projects/goffice/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 sparc x86"
IUSE="gnome"
#cairo support broken and -gtk broken

RDEPEND=">=dev-libs/glib-2.6.3
	>=gnome-extra/libgsf-1.13.3
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.8.1
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.3.6
	>=gnome-base/libgnomeprint-2.8.2
	>=media-libs/libart_lgpl-2.3.11
	gnome? (
		>=gnome-base/gconf-2
		>=gnome-base/libgnomeui-2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"

DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README"
USE_DESTDIR="1"

pkg_setup() {
	G2CONF="$(use_with gnome)"

	if use gnome && ! built_with_use gnome-extra/libgsf gnome; then
		eerror "Please rebuild gnome-extra/libgsf with gnome support enabled"
		eerror "USE=\"gnome\" emerge gnome-extra/libgsf"
		eerror "or add  \"gnome\" to your USE string in /etc/make.conf"
		die "No Gnome support found in libgsf"
	fi
}

src_compile() {
	filter-flags -ffast-math
	gnome2_src_compile
}

pkg_postinst() {
	ewarn "You must recompile all packages that are linked against"
	ewarn "goffice-0.1.* by using revdep-rebuild from gentoolkit:"
	ewarn "# revdep-rebuild --library libgoffice-1.so.1"
}
