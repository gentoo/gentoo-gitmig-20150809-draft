# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libglademm/libglademm-2.0.1.ebuild,v 1.6 2004/04/12 17:06:27 aliz Exp $

inherit gnome2
IUSE=""
DESCRIPTION="C++ bindings for libglade"
HOMEPAGE="http://gtkmm.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

RDEPEND=">=gnome-base/libglade-2
	>=dev-cpp/gtkmm-2.0.2"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

# Needed for 2.0.0, it misses some make/libtool magic
export SED=sed

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO INSTALL"
