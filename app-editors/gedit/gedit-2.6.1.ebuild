# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.6.1.ebuild,v 1.1 2004/05/04 15:10:04 foser Exp $

inherit gnome2

DESCRIPTION="A text editor for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"
IUSE="spell"

RDEPEND=">=gnome-base/libglade-2.3.6
	>=dev-libs/popt-1.5
	>=gnome-base/eel-2.6
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/libgnomeprintui-2.6
	>=x11-libs/gtksourceview-1
	spell? ( virtual/aspell-dict )"
# FIXME : spell autodetect only

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.29"

DOCS="AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README THANKS TODO"
