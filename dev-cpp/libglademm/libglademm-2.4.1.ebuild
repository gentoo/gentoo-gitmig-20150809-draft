# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libglademm/libglademm-2.4.1.ebuild,v 1.5 2005/04/08 13:22:22 gustavoz Exp $

inherit gnome2 eutils

DESCRIPTION="C++ bindings for libglade"
HOMEPAGE="http://gtkmm.sourceforge.net/"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/libglademm/2.4/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2.4"
KEYWORDS="~amd64 ~ppc ~x86 sparc"
IUSE=""

RDEPEND=">=gnome-base/libglade-2.3.6
	>=dev-cpp/gtkmm-2.4"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

src_compile() {
	if [ "${ARCH}" = "amd64" ]; then
		aclocal -I scripts
		libtoolize --force --copy
		automake -c -f
		autoconf
	fi
	gnome2_src_compile
}

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO INSTALL"
