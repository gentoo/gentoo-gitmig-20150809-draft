# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libbonobo/libbonobo-2.0.0-r1.ebuild,v 1.11 2003/09/06 23:51:37 msterret Exp $

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="a CORBA framework "
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
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

