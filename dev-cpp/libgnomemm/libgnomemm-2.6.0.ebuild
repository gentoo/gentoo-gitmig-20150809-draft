# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomemm/libgnomemm-2.6.0.ebuild,v 1.2 2004/05/21 13:59:26 khai Exp $

inherit gnome2
IUSE=""
DESCRIPTION="C++ bindings for libgnome"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"

KEYWORDS="~x86"
SLOT="2.6"

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=gnome-base/libgnome-2.6"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"

src_compile() {
	gnome2_src_compile
}
