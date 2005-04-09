# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomecanvasmm/libgnomecanvasmm-2.6.1.ebuild,v 1.10 2005/04/09 15:35:40 corsair Exp $

inherit gnome2

DESCRIPTION="C++ bindings for libgnomecanvasmm"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/libgnomecanvasmm/2.6/${P}.tar.bz2"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
SLOT="2.6"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~amd64 ~ppc sparc ~ppc64"

RDEPEND=">=gnome-base/libgnomecanvas-2.6
	>=dev-cpp/gtkmm-2.4"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO INSTALL"

src_compile() {
	if [ use amd64 ]; then
		aclocal -I scrips
		automake -c -f
		autoconf
		libtoolize --copy --force
	fi
	gnome2_src_compile
}
