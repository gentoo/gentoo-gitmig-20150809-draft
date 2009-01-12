# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monster-masher/monster-masher-1.8.ebuild,v 1.9 2009/01/12 16:14:38 mr_bones_ Exp $

EAPI=2
inherit eutils gnome2

DESCRIPTION="Squash the monsters with your levitation worker gnome"
HOMEPAGE="http://people.iola.dk/olau/monster-masher/"
SRC_URI="http://people.iola.dk/olau/monster-masher/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libSM
	>=dev-cpp/gtkmm-2.6
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/libgnomecanvasmm-2.6
	gnome-base/libgnome[esd]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	DOCS="AUTHORS ChangeLog README" gnome2_src_install
}
