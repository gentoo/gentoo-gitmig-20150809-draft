# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/bug-buddy/bug-buddy-2.2.106.ebuild,v 1.1 2003/06/10 15:28:49 foser Exp $

inherit gnome2

DESCRIPTION="Bug report tool for GNOME"
HOMEPAGE="http://www.gnome.org/"

SLOT="2"
LICENSE="Ximian-logos GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND=">=gnome-base/libglade-2
	>=dev-libs/libxml2-2.4.16
	>=gnome-base/gnome-vfs-2
	>=x11-libs/gtk+-2
	>=gnome-base/bonobo-activation-1
	>=gnome-base/gnome-desktop-2
	>=gnome-base/libbonobo-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/libgnomeui-2.2"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
        dev-util/intltool
	>=app-text/scrollkeeper-0.3.8"

DOCS="ABOUT* AUTHORS ChangeLog COPY* README* INSTALL NEWS TODO"
