# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomecanvasmm/libgnomecanvasmm-2.0.1.ebuild,v 1.14 2004/07/19 17:20:49 pylon Exp $

inherit eutils gnome2

DESCRIPTION="C++ bindings for libgnomecanvasmm"
HOMEPAGE="http://gtkmm.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2.0"
KEYWORDS="~x86 ppc ~sparc hppa amd64"
IUSE=""

RDEPEND=">=gnome-base/libgnomecanvas-2
	>=dev-cpp/gtkmm-2.2.5"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO INSTALL"

src_unpack() {
	unpack ${A}
	cd ${S}; epatch ${FILESDIR}/2.0.1-gcc3.4-to-cvs.patch
	cd ${S}; epatch ${FILESDIR}/2.0.1-gcc3.4-after-cvs.patch
}

src_compile() {
	use amd64 && aclocal -I scripts && automake && autoconf
	gnome2_src_compile
}
