# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnome-vfsmm/gnome-vfsmm-2.10.0.ebuild,v 1.2 2006/08/13 18:14:47 corsair Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gnome-vfs"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
SLOT="1.1"

RDEPEND=">=gnome-base/gnome-vfs-2.6
	>=dev-cpp/glibmm-2.4"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"

src_compile() {
	if useq amd64; then
		aclocal -I scripts
		automake -c -f
		autoconf
		libtoolize	--copy --force
	fi

	gnome2_src_compile
}
