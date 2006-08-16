# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomemm/libgnomemm-2.12.2.ebuild,v 1.13 2006/08/16 15:02:25 corsair Exp $

inherit gnome2

DESCRIPTION="C++ bindings for libgnome"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND=">=dev-cpp/gtkmm-2.4
	>=gnome-base/libgnome-2.6"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_compile() {
	if useq amd64; then
		aclocal -I scripts
		automake -c -f
		autoconf
		libtoolize --copy --force
	fi

	gnome2_src_compile
}
