# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgnomeuimm/libgnomeuimm-1.3.9.ebuild,v 1.1 2002/09/13 13:06:19 spider Exp $


inherit gnome2

S=${WORKDIR}/${P}
SLOT="0"
DESCRIPTION="C++ bindings for libgnomeuimm"
SRC_URI="mirror://sourceforge/gtkmm/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc"


RDEPEND=">=gnome-base/libgnomeui-2.0.0
	>=gnome-extra/libgnomemm-1.3.6
	>=gnome-extra/libgnomecanvasmm-1.3.8
	>=gnome-extra/gconfmm-1.3.6
	>=x11-libs/gtkmm-1.3.18
	>=gnome-extra/libglademm-1.3.2"


DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"


DOCS="AUTHORS COPYING ChangeLog NEWS README TODO"
