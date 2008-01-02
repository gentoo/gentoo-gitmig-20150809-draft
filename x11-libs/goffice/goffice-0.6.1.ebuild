# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/goffice/goffice-0.6.1.ebuild,v 1.5 2008/01/02 14:28:46 armin76 Exp $

inherit eutils gnome2 flag-o-matic

DESCRIPTION="A library of document-centric objects and utilities"
HOMEPAGE="http://freshmeat.net/projects/goffice/"

LICENSE="GPL-2"
SLOT="0.6"
KEYWORDS="alpha ~amd64 hppa ia64 ~ppc ~ppc64 sparc x86"
IUSE="gnome"
#doc support is broken without gtk-doc 1.9
#cairo support broken and -gtk broken

RDEPEND=">=dev-libs/glib-2.8.0
	>=gnome-extra/libgsf-1.13.3
	>=dev-libs/libxml2-2.4.12
	>=x11-libs/pango-1.8.1
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.3.6
	>=gnome-base/libgnomeprint-2.8.2
	>=media-libs/libart_lgpl-2.3.11
	>=x11-libs/cairo-1.2
	gnome? (
		>=gnome-base/gconf-2
		>=gnome-base/libgnomeui-2 )
	  dev-libs/libpcre"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.18
	>=dev-util/intltool-0.35"
#	doc? ( >=dev-util/gtk-doc-1.4 )"

DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} $(use_with gnome)"

	if use gnome && ! built_with_use gnome-extra/libgsf gnome; then
		eerror "Please rebuild gnome-extra/libgsf with gnome support enabled"
		eerror "USE=\"gnome\" emerge gnome-extra/libgsf"
		eerror "or add  \"gnome\" to your USE string in /etc/make.conf"
		die "No Gnome support found in libgsf"
	fi

	if ! built_with_use x11-libs/cairo svg ; then
		eerror
		eerror "Please rebuild x11-libs/cairo with svg support enabled"
		eerror "echo \"x11-libs/cairo svg\" >> /etc/portage/package.use"
		eerror "emerge -1 x11-libs/cairo"
		eerror
		die "cairo built with -svg"
	fi
}

src_unpack() {
	gnome2_src_unpack

	# strip doc installation
	# needs gtk-doc-1.9 otherwise
	epatch "${FILESDIR}/${P}-die-gtk-doc.patch"
}

src_compile() {
	filter-flags -ffast-math
	gnome2_src_compile
}
