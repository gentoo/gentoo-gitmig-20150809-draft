# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/eel/eel-2.0.8.ebuild,v 1.4 2002/12/15 10:44:19 bjb Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="EEL is the Eazel Extentions Library"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2 LGPL-2.1" 
KEYWORDS="x86 ~ppc ~sparc ~alpha"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-1.2.1
	>=x11-libs/gtk+-2.0.6-r1
	>=media-libs/libart_lgpl-2.3.10
	>=dev-libs/libxml2-2.4.7
	>=gnome-base/gnome-vfs-2
	>=dev-libs/popt-1.6.3
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2
	>=gnome-base/gail-0.16"

DEPEND="${RDEPEND} 
	>=dev-util/pkgconfig-0.12.0"		

LIBTOOL_FIX="1"

DOCS="AUTHORS ChangeLog COPYING* HACKING THANKS README* INSTALL NEWS TODO MAINTAINERS"
