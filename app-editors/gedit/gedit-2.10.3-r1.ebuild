# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.10.3-r1.ebuild,v 1.2 2005/08/23 22:07:11 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="A text editor for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE="spell"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=x11-libs/gtksourceview-1.2
	>=gnome-base/libgnomeui-2.8
	>=gnome-base/libglade-2.4
	>=gnome-base/eel-2.6
	>=gnome-base/libgnomeprintui-2.6
	>=dev-libs/popt-1.5
	>=gnome-base/gconf-2
	spell? ( virtual/aspell-dict )"
# FIXME : spell autodetect only

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.31"

DOCS="AUTHORS BUGS ChangeLog README THANKS TODO"

USE_DESTDIR="1"

src_unpack() {

	unpack ${A}

	cd ${S}
	# fix save as (http://bugzilla.gnome.org/show_bug.cgi?id=311187)
	epatch ${FILESDIR}/${P}-save_as.patch

}

