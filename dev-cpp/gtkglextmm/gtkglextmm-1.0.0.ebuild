# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkglextmm/gtkglextmm-1.0.0.ebuild,v 1.4 2004/07/13 23:39:09 khai Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gtkglext"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"
HOMEPAGE="http://gtkglext.sourceforge.net/"

KEYWORDS="x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
DEPEND=">=x11-libs/gtkglext-1.0.0
	=dev-cpp/gtkmm-2.2*
	virtual/x11
	virtual/opengl
	virtual/glu"

