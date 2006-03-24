# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gconfmm/gconfmm-2.12.0.ebuild,v 1.8 2006/03/24 04:49:19 agriffis Exp $

inherit gnome2 eutils

DESCRIPTION="C++ bindings for GConf"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 hppa ~ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2.4
	>=dev-cpp/glibmm-2.4
	>=dev-cpp/gtkmm-2.4"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"

src_compile() {
	if useq amd64 || useq ppc64; then
		aclocal -I scripts
		libtoolize --force --copy
		automake -c -f
		autoconf
	fi

	gnome2_src_compile
}
