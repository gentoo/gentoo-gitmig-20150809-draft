# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libbonobomm/libbonobomm-1.3.7.ebuild,v 1.1 2003/08/31 06:15:22 obz Exp $

inherit gnome2

DESCRIPTION="C++ bindings for libbonobo"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=gnome-base/libbonobo-2.0
	>=gnome-base/bonobo-activation-2.0
	>=gnome-base/ORBit2-2	
	>=dev-cpp/gtkmm-2.0.0
	>=dev-cpp/orbitcpp-1.3.7"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README INSTALL"
