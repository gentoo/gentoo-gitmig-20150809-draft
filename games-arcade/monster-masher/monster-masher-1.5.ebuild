# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monster-masher/monster-masher-1.5.ebuild,v 1.2 2004/06/24 22:08:31 agriffis Exp $

DESCRIPTION="Squash the monsters with your levitation worker gnome"
HOMEPAGE="http://www.cs.auc.dk/~olau/monster-masher/"
SRC_URI="http://www.cs.auc.dk/~olau/monster-masher/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="virtual/x11
	dev-cpp/gtkmm
	dev-cpp/libgnomemm
	dev-cpp/libgnomeuimm
	dev-cpp/gconfmm
	dev-cpp/libglademm"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog README
}
