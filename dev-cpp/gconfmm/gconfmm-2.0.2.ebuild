# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gconfmm/gconfmm-2.0.2.ebuild,v 1.2 2004/06/13 06:56:09 lv Exp $

inherit gnome2

DESCRIPTION="C++ bindings for GConf"
SRC_URI="mirror://gnome/sources/${PN}/2.0/${P}.tar.bz2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc hppa amd64"
SLOT="2"

RDEPEND=">=gnome-base/gconf-1.2.0
	>=dev-cpp/gtkmm-2.0.1"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"

src_compile() {
	use amd64 && aclocal -I scripts && automake && autoconf
	gnome2_src_compile
}
