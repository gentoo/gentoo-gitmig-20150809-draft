# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkglextmm/gtkglextmm-1.0.1.ebuild,v 1.1 2003/11/25 20:07:53 foser Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gtkglext"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"

KEYWORDS="~x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"

DEPEND=">=x11-libs/gtkglext-1
	>=dev-cpp/gtkmm-2
	virtual/x11
	virtual/opengl
	virtual/glu"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

