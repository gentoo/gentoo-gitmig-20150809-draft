# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonobo/libbonobo-2.0.0-r1.ebuild,v 1.2 2002/08/04 22:06:58 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="a CORBA framework "
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="LGPL-2.1 GPL-2"

RDEPEND=">=dev-libs/glib-2.0.0
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/bonobo-activation-1.0.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17
	doc? ( >=dev-util/gtk-doc-0.9-r2 )"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README TODO"
src_compile () {
	gnome2_src_configure 
	make || die "serial make failure"
		 
}

