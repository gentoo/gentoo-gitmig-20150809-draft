# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.5.92.ebuild,v 1.1 2004/03/21 16:24:10 foser Exp $

inherit gnome2

DESCRIPTION="A text editor for the Gnome2 desktop"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~mips"
IUSE="spell"

RDEPEND=">=gnome-base/libglade-2
	>=dev-libs/popt-1.5
	>=gnome-base/eel-2.5
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2.5
	>=gnome-base/libgnomeprintui-2.5
	>=x11-libs/gtksourceview-0.9
	spell? ( virtual/aspell-dict )"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.29"

# FIXME : spell autodetect only

DOCS="AUTHORS BUGS ChangeLog COPYING INSTALL NEWS README THANKS TODO"
