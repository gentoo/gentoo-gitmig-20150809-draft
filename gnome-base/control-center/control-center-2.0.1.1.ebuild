# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-2.0.1.1.ebuild,v 1.3 2002/09/21 12:09:35 bjb Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="the gnome2 Desktop configuration tool"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

RDEPEND=">=x11-libs/gtk+-2.0.6
	>=dev-libs/glib-2.0.6
	>=gnome-base/gconf-1.2.1
	>=gnome-base/libgnomeui-2.0.5
	>=gnome-base/libglade-2.0.1
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/libbonoboui-2.0.3
	>=gnome-base/gnome-vfs-2.0.4
	>=gnome-base/gnome-desktop-2.0.8
	>=app-text/scrollkeeper-0.3.11"
																		
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0" 

DOCS="AUTHORS ChangeLog COPYING README* TODO INSTALL NEWS"

