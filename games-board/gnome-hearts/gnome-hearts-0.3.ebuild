# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnome-hearts/gnome-hearts-0.3.ebuild,v 1.1 2010/01/12 17:45:09 mr_bones_ Exp $

EAPI=2
GCONF_DEBUG=no
inherit autotools eutils gnome2 games

DESCRIPTION="A clone of classic hearts card game"
HOMEPAGE="http://www.gnome-hearts.org"
SRC_URI="http://www.jejik.com/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="x11-libs/gtk+:2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2
	dev-lang/python"
DEPEND="${RDEPEND}
	app-text/rarian
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_prepare() {
	gnome2_src_prepare
	epatch "${FILESDIR}"/${P}-python.patch
	intltoolize --force --copy --automake || die
	eautoreconf
}

src_configure() {
	gnome2_src_configure \
		--bindir="${GAMES_BINDIR}" \
		$(use_enable nls)
}

src_install() {
	gnome2_src_install
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_pkg_preinst
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_pkg_postinst
}
