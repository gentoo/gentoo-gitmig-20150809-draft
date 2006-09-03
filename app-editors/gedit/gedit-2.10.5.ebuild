# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.10.5.ebuild,v 1.12 2006/09/03 20:50:29 kumba Exp $

inherit gnome2

DESCRIPTION="A text editor for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="spell static"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=x11-libs/gtksourceview-1.2
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libglade-2.4
	>=gnome-base/eel-2.6
	>=gnome-base/libgnomeprintui-2.6
	>=dev-libs/popt-1.5
	>=gnome-base/gconf-2
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	spell? ( virtual/aspell-dict )"
# FIXME : spell autodetect only

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.31"

DOCS="AUTHORS BUGS ChangeLog MAINTAINERS README THANKS TODO"

USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_enable static)"
}
