# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonoboui/libbonoboui-2.2.0.1.ebuild,v 1.4 2003/05/29 23:18:49 lu_zero Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="User Interface part of Lib bonobo"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/bonobo-activation-1
	>=gnome-base/libbonobo-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomecanvas-2
	>=gnome-base/gconf-1.2.1
	>=dev-libs/libxml2-2.4.20"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
