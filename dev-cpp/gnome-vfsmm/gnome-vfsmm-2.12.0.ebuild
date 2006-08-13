# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnome-vfsmm/gnome-vfsmm-2.12.0.ebuild,v 1.13 2006/08/13 18:14:47 corsair Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gnome-vfs"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND=">=gnome-base/gnome-vfs-2.6
	>=dev-cpp/glibmm-2.4"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README INSTALL"

src_compile() {
	if useq amd64; then
		aclocal -I scripts
		automake -c -f
		autoconf
		libtoolize	--copy --force
	fi

	gnome2_src_compile
}
