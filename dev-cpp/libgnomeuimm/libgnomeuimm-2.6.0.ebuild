# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomeuimm/libgnomeuimm-2.6.0.ebuild,v 1.11 2005/04/08 13:25:45 gustavoz Exp $

inherit gnome2 eutils

DESCRIPTION="C++ bindings for libgnomeui"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="~x86 ~amd64 ~ppc sparc"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2.6
	>=dev-cpp/libgnomemm-2.6
	>=dev-cpp/libgnomecanvasmm-2.6
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/gnome-vfsmm-2.6"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS INSTALL TODO"

src_compile() {
	use amd64 && aclocal -I scripts && automake -c -f && autoconf && libtoolize --copy --force
	gnome2_src_compile
}
