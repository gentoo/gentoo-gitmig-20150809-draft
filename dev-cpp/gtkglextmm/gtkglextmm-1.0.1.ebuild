# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkglextmm/gtkglextmm-1.0.1.ebuild,v 1.7 2005/01/01 17:26:45 eradicator Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gtkglext"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"

KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=x11-libs/gtkglext-1
	=dev-cpp/gtkmm-2.2*
	virtual/x11
	virtual/opengl
	virtual/glu"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	if [ "${ARCH}" = "amd64" ]; then
		aclocal -I m4macros
		automake -c -f
		autoconf
	fi
	gnome2_src_compile
}
