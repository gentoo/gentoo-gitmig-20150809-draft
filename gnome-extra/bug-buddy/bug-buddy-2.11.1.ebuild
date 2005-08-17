# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/bug-buddy/bug-buddy-2.11.1.ebuild,v 1.1 2005/08/17 16:52:36 leonardop Exp $

inherit gnome2

DESCRIPTION="A graphical bug reporting tool"
HOMEPAGE="http://www.gnome.org/"

LICENSE="Ximian-logos GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=gnome-base/libbonobo-2
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2
	>=gnome-base/gnome-desktop-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-menus-2.11.1
	>=gnome-base/libgnomeui-2.5.92
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2.4.6

	>=sys-devel/gdb-5.1"

DEPEND=">=gnome-base/gconf-2
	>=gnome-base/libbonobo-2
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2
	>=gnome-base/gnome-desktop-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-menus-2.11.1
	>=gnome-base/libgnomeui-2.5.92
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2.4.6

	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.8"

DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"


src_unpack() {
	unpack ${A}
	cd ${S}
	gnome2_omf_fix gnome-doc-utils.make docs/Makefile.in
}
