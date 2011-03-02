# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate-gtk/qalculate-gtk-0.9.7.ebuild,v 1.7 2011/03/02 21:25:34 jlec Exp $

EAPI=2
GCONF_DEBUG=no
inherit eutils gnome2

DESCRIPTION="A modern multi-purpose calculator"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc sparc x86"
IUSE="gnome"

RDEPEND="
	>=sci-libs/libqalculate-0.9.7
	>=sci-libs/cln-1.2
	x11-libs/gtk+:2
	gnome-base/libglade:2.0
	gnome? (
		>=gnome-base/libgnome-2
		gnome-extra/yelp )"
DEPEND="${RDEPEND}
	app-text/rarian
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="--disable-dependency-tracking
		$(use_with gnome libgnome)"
}

src_prepare() {
	# Required by make check
	echo data/periodictable.glade > po/POTFILES.skip
	epatch "${FILESDIR}"/${P}-entry.patch
	gnome2_src_prepare
}
