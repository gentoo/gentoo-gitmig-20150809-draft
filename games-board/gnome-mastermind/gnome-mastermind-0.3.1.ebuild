# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnome-mastermind/gnome-mastermind-0.3.1.ebuild,v 1.1 2008/04/27 02:25:32 mr_bones_ Exp $

inherit eutils gnome2

DESCRIPTION="A little Mastermind game for GNOME"
HOMEPAGE="http://www5.autistici.org/gnome-mastermind/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="gnome-base/gconf
	gnome-base/orbit
	app-text/gnome-doc-utils
	dev-libs/atk
	dev-libs/glib
	x11-libs/pango
	x11-libs/cairo
	x11-libs/gtk+"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	app-text/scrollkeeper"

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS TODO" gnome2_src_install
}
