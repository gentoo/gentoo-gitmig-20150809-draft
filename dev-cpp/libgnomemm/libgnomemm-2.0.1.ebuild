# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomemm/libgnomemm-2.0.1.ebuild,v 1.19 2006/05/15 03:45:19 tcort Exp $

inherit gnome2
IUSE=""
DESCRIPTION="C++ bindings for libgnome"
#SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"

KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
SLOT="2"

RDEPEND="=dev-cpp/gtkmm-2.2*
	>=gnome-base/libgnome-2"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"

src_compile() {
	if useq amd64 || useq ppc64; then
		aclocal -I scripts
		automake
		autoconf
		libtoolize --copy --force
	fi

	gnome2_src_compile
}
