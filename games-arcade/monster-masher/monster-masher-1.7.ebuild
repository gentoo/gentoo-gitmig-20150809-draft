# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monster-masher/monster-masher-1.7.ebuild,v 1.2 2004/07/07 18:08:10 mr_bones_ Exp $

DESCRIPTION="Squash the monsters with your levitation worker gnome"
HOMEPAGE="http://www.cs.auc.dk/~olau/monster-masher/"
SRC_URI="http://www.cs.auc.dk/~olau/monster-masher/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/x11
	=dev-cpp/gtkmm-2.4*
	=dev-cpp/libgnomemm-2.6*
	=dev-cpp/libgnomeuimm-2.6*
	=dev-cpp/gconfmm-2.6*
	=dev-cpp/libglademm-2.4*"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
