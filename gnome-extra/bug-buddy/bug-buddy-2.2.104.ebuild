# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/bug-buddy/bug-buddy-2.2.104.ebuild,v 1.1 2003/05/16 09:47:00 liquidx Exp $

inherit gnome2

IUSE=""
DESCRIPTION="Bug Report helper for Gnome"
HOMEPAGE="http://www.gnome.org/"

SLOT="2"
LICENSE="Ximian-logos GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND=">=gnome-base/gconf-1.2.0
	>=gnome-base/libglade-2.0.0
	>=dev-libs/libxml2-2.4.16
	>=gnome-base/gnome-vfs-2.0.0
	>=x11-libs/pango-1.0.3
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/glib-2.0.3
	>=gnome-base/bonobo-activation-1.0.0
	>=gnome-base/gnome-desktop-2.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=gnome-base/libgnomeui-2.1.0
	>=gnome-base/ORBit2-2.4.0
	>=dev-lang/perl-5.0
	>=sys-devel/gdb-5.1
	>=sys-devel/gettext-0.10.40
	>=dev-lang/python-2.2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
        >=dev-util/intltool-0.17
	app-text/scrollkeeper"

DOCS="ABOUT* AUTHORS ChangeLog COPY* README* INSTALL NEWS TODO"
