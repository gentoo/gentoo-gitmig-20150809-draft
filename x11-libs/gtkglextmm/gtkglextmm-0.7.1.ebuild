# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkglextmm/gtkglextmm-0.7.1.ebuild,v 1.3 2003/05/05 12:02:39 liquidx Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gtkglext"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"
HOMEPAGE="http://gtkglext.sourceforge.net/"

KEYWORDS="x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
DEPEND=">=x11-libs/gtkglext-0.7.1
	>=x11-libs/gtkmm-2.0
	virtual/x11
	virtual/opengl
	virtual/glu"

