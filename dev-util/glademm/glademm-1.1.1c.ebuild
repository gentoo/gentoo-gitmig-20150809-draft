# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-1.1.1c.ebuild,v 1.1 2002/10/09 19:12:18 foser Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A C++ code generating backend for glade"
SRC_URI="http://home.wtal.de/petig/Gtk/${P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=dev-util/glade-1.1.1
	>=x11-libs/gtk+-2.0.4
	>=x11-libs/gtkmm-1.3.5
	>=gnome-extra/libgnomemm-1.3.3"

src_compile() {
	econf || die
	make || die
}

src_install () {
	einstall || die
}
