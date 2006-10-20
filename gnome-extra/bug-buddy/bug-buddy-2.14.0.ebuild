# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/bug-buddy/bug-buddy-2.14.0.ebuild,v 1.10 2006/10/20 22:03:49 agriffis Exp $

inherit gnome2

DESCRIPTION="A graphical bug reporting tool"
HOMEPAGE="http://www.gnome.org/"

LICENSE="Ximian-logos GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
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

DEPEND=${RDEPEND}"
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.8"

DOCS="AUTHORS ChangeLog NEWS README TODO"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="${G2CONF}--disable-scrollkeeper"
}
