# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monster-masher/monster-masher-1.8.ebuild,v 1.7 2008/02/14 00:46:50 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Squash the monsters with your levitation worker gnome"
HOMEPAGE="http://people.iola.dk/olau/monster-masher/"
SRC_URI="http://people.iola.dk/olau/monster-masher/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-libs/libSM
	>=dev-cpp/gtkmm-2.6
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/libgnomecanvasmm-2.6
	gnome-base/libgnome"

pkg_setup() {
	if ! built_with_use gnome-base/libgnome esd ; then
		die "You need to compile gnome-base/libgnome with esd USE flag!"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
