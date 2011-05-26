# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monster-masher/monster-masher-1.8.1-r1.ebuild,v 1.2 2011/05/26 21:22:15 maekke Exp $

EAPI=3
GCONF_DEBUG="no"

inherit autotools eutils gnome2

DESCRIPTION="Squash the monsters with your levitation worker gnome"
HOMEPAGE="http://people.iola.dk/olau/monster-masher/"
SRC_URI="http://people.iola.dk/olau/monster-masher/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libSM
	>=dev-cpp/gtkmm-2.6:2.4
	>=dev-cpp/gconfmm-2.6
	>=dev-cpp/libglademm-2.4:2.4
	>=dev-cpp/libgnomecanvasmm-2.6:2.6
	gnome-base/libgnome
	media-libs/libcanberra"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	# Port to libcanberra, bug #348605
	epatch "${FILESDIR}"/${P}-libcanberra.patch

	intltoolize --force --copy --automake || die
	eautoreconf

	gnome2_src_prepare
}

src_install() {
	DOCS="AUTHORS ChangeLog README" gnome2_src_install
}
