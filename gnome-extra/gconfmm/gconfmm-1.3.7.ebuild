# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gconfmm/gconfmm-1.3.7.ebuild,v 1.1 2002/09/13 13:06:19 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="C++ bindings for libgconf"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND=">=gnome-base/gconf-1.2.0
	>=x11-libs/gtkmm-1.3.17"


DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"

