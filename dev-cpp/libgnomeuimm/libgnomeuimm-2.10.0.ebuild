# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomeuimm/libgnomeuimm-2.10.0.ebuild,v 1.3 2006/08/13 19:00:24 corsair Exp $

inherit gnome2 eutils

DESCRIPTION="C++ bindings for libgnomeui"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~hppa"
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
	if useq amd64; then
		aclocal -I scripts
		automake -c -f
		autoconf
		libtoolize --copy --force
	fi

	gnome2_src_compile
}
