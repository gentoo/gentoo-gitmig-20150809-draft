# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgnomedb/libgnomedb-3.1.2.ebuild,v 1.3 2011/03/08 05:28:00 nirbheek Exp $

EAPI="2"

inherit gnome2

DESCRIPTION="Database widget library from the GNOME-DB project"
HOMEPAGE="http://www.gnome-db.org/"

LICENSE="GPL-2"
SLOT="3"
# Does not build
KEYWORDS="-*"

IUSE="doc"

# Dependencies here are set looking to obtain the most functionality, given that
# they are not unreasonable (e.g. gtk+'s version, gconf even if it's optional,
# etc.).
#
# There is no evolution-data-server support yet, only a check in configure.
# FIXME: automagic: goocanvas, graphviz, glade-3
RDEPEND=">=x11-libs/gtk+-2.10:2
	>=gnome-base/gconf-2:2
	gnome-extra/libgda:3
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libglade-2:2.0
	x11-libs/gtksourceview:1.0
	>=dev-libs/libgcrypt-1.1.14
	>=x11-libs/goocanvas-0.9:0
	media-gfx/graphviz
	>=dev-util/glade-3.1:3
	app-text/iso-codes"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"
