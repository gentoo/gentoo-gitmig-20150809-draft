# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-2.1.2.ebuild,v 1.2 2002/11/28 01:18:16 spider Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="the gnome2 Desktop configuration tool"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND="=x11-libs/gtk+-2.1*
	>=dev-libs/glib-2.0.6
	>=gnome-base/gconf-1.2.1
	=gnome-base/libgnomeui-2.1*
	>=gnome-base/libglade-2.0.1
	=gnome-base/libbonobo-2.1*
	=gnome-base/libbonoboui-2.1*
	=gnome-base/gnome-vfs-2.1*
	=gnome-base/gnome-desktop-2.1*
	>=app-text/scrollkeeper-0.3.11"
																		
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0" 

src_unpack() {
	unpack ${A}

	# Fix font capplet not linking to the right libXft
	cd ${S}/capplets/font
	cp Makefile.in Makefile.in.orig
	sed -e "s:FONT_CAPPLET_LIBS =:FONT_CAPPLET_LIBS = -L/usr/lib:" \
		Makefile.in.orig > Makefile.in

}

DOCS="AUTHORS ChangeLog COPYING README* TODO INSTALL NEWS"

