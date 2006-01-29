# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monster-masher/monster-masher-1.7.ebuild,v 1.5 2006/01/29 00:00:27 joshuabaergen Exp $

inherit eutils

DESCRIPTION="Squash the monsters with your levitation worker gnome"
HOMEPAGE="http://www.cs.auc.dk/~olau/monster-masher/"
SRC_URI="http://www.cs.auc.dk/~olau/monster-masher/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="|| ( x11-libs/libSM virtual/x11 )
	=dev-cpp/gtkmm-2.4*
	=dev-cpp/libgnomemm-2.6*
	=dev-cpp/libgnomeuimm-2.6*
	=dev-cpp/gconfmm-2.6*
	=dev-cpp/libglademm-2.4*
	gnome-base/libgnome"

pkg_setup() {
	if ! built_with_use gnome-base/libgnome esd
	then
		die "You need to compile gnome-base/libgnome with esd USE flag!"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
