# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgnomecanvasmm/libgnomecanvasmm-1.3.5.ebuild,v 1.1 2002/06/02 17:24:26 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="C++ bindings for libgnomecanvasmm"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"


RDEPEND=">=gnome-base/libgnomecanvas-1.117.0
	>=x11-libs/gtkmm-1.3.14"


DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOC="AUTHORS COPYING ChangeLog NEWS README TODO"
