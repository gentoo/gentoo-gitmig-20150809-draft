# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Spider <spider@gentoo.org> 
# Maintainer:  Spider <spider@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-1.1.18-r1.ebuild,v 1.1 2002/06/04 09:48:08 blocke Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A filemanager for the Gnome2 desktop"
SRC_URI="ftp://ftp.gnome.org/pub/gnome/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"

RDEPEND=">=dev-libs/glib-2.0.1
	>=gnome-base/gconf-1.1.10
	>=x11-libs/gtk+-2.0.2
	>=dev-libs/libxml2-2.4.22
	>=gnome-base/gnome-vfs-1.9.12
	>=media-sound/esound-0.2.25
	>=gnome-base/bonobo-activation-0.9.9
	>=gnome-base/eel-1.1.16
	>=gnome-base/libgnome-1.117.2
	>=gnome-base/libgnomeui-1.117.2
	>=gnome-base/gnome-desktop-1.5.21
	>=media-libs/libart_lgpl-2.3.8-r1
	>=gnome-base/libbonobo-1.117.1
	>=gnome-base/libbonoboui-1.117.1
	>=gnome-base/libgnomecanvas-1.117.0
	>=gnome-base/librsvg-1.1.6
	>=app-text/scrollkeeper-0.3.6"

DEPEND="${RDEPEND} >=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYIN* ChangeLo* HACKING INSTALL MAINTAINERS NEWS README THANKS TODO"
SCHEMAS="nautilus.schemas apps_nautilus_preferences.schemas"

src_compile() {
	gnome2_src_compile --enable-platform-gnome-2
}

