# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgnomecanvasmm/libgnomecanvasmm-2.0.0.ebuild,v 1.3 2004/02/16 21:30:45 gustavoz Exp $

inherit gnome2


DESCRIPTION="C++ bindings for libgnomecanvasmm"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc sparc"

RDEPEND=">=gnome-base/libgnomecanvas-2.0.0
	>=dev-cpp/gtkmm-2.0.1"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO INSTALL"
