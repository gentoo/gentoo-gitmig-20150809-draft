# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gedit/gedit-2.14.4.ebuild,v 1.9 2006/10/19 15:45:42 kloeri Exp $

inherit gnome2

DESCRIPTION="A text editor for the GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~ppc ppc64 sh sparc ~x86"
IUSE="spell python"

RDEPEND=">=gnome-base/gconf-2
	>=dev-libs/glib-2.8
	>=x11-libs/gtk+-2.8
	>=x11-libs/gtksourceview-1.2
	>=gnome-base/libgnomeui-2.13
	>=gnome-base/libglade-2.4
	>=gnome-base/libgnomeprintui-2.6
	>=gnome-base/gnome-vfs-2.13.4
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	spell? ( virtual/aspell-dict )
	python? (
		>=dev-python/pygtk-2.8
		>=dev-python/gnome-python-desktop-2.13.3
	)"
# FIXME : spell autodetect only

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.9
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.31
	>=app-text/gnome-doc-utils-0.3.2"

DOCS="AUTHORS BUGS ChangeLog MAINTAINERS NEWS README THANKS TODO"
