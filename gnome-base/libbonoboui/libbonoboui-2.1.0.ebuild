# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonoboui/libbonoboui-2.1.0.ebuild,v 1.3 2002/11/30 23:33:06 nall Exp $

inherit gnome2 debug

S=${WORKDIR}/${P}
DESCRIPTION="User Interface part of Lib bonobo"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=x11-libs/gtk+-2.0.2
	=gnome-base/bonobo-activation-2.1*
	=gnome-base/libbonobo-2.1*
	>=gnome-base/libglade-2
	=gnome-base/libgnome-2.1*
	=gnome-base/libgnomecanvas-2.1*
	>=gnome-base/gconf-1.2.1"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"

LIBTOOL_FIX="0"
DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

