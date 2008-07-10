# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libglademm/libglademm-2.0.1.ebuild,v 1.13 2008/07/10 15:20:06 remi Exp $

inherit gnome2
IUSE=""
DESCRIPTION="C++ bindings for libglade"
HOMEPAGE="http://www.gtkmm.org"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="amd64 hppa ~ia64 ppc sparc x86"

RDEPEND=">=gnome-base/libglade-2
	=dev-cpp/gtkmm-2.2*"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

# Needed for 2.0.0, it misses some make/libtool magic
export SED=sed

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO INSTALL"
