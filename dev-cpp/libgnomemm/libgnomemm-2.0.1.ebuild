# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomemm/libgnomemm-2.0.1.ebuild,v 1.14 2004/10/24 19:18:58 kloeri Exp $

inherit gnome2
IUSE=""
DESCRIPTION="C++ bindings for libgnome"
#SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"

KEYWORDS="x86 ppc sparc hppa amd64 ~alpha"
SLOT="2"

RDEPEND="=dev-cpp/gtkmm-2.2*
	>=gnome-base/libgnome-2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"

src_compile() {
	use amd64 && aclocal -I scripts && automake && autoconf
	gnome2_src_compile
}
