# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gconfmm/gconfmm-2.6.1.ebuild,v 1.9 2004/12/08 21:08:52 hansmi Exp $

IUSE=""

inherit gnome2

DESCRIPTION="C++ bindings for GConf"
HOMEPAGE="http://gtkmm.sourceforge.net/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"

RDEPEND=">=gnome-base/gconf-2.4
	>=dev-cpp/glibmm-2.4
	>=dev-cpp/gtkmm-2.4"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"

src_compile() {
	if [ "${ARCH}" = "amd64" ]; then
		aclocal -I scripts
		automake -c -f
		autoconf
	fi
	gnome2_src_compile
}
