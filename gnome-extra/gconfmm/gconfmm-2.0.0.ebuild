# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gconfmm/gconfmm-2.0.0.ebuild,v 1.1 2002/12/22 18:58:12 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="C++ bindings for libgconf"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=gnome-base/gconf-1.2.0
	>=x11-libs/gtkmm-2.0.1"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"
