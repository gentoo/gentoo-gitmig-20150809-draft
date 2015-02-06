# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/ltris/ltris-1.0.19.ebuild,v 1.2 2015/02/06 08:07:08 mr_bones_ Exp $

EAPI=5
inherit autotools gnome2-utils eutils games

DESCRIPTION="very polished Tetris clone"
HOMEPAGE="http://lgames.sourceforge.net/index.php?project=LTris"
SRC_URI="mirror://sourceforge/lgames/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND="media-libs/libsdl[video]
	media-libs/sdl-mixer
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	mv configure.in configure.ac || die
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	egamesconf $(use_enable nls)
}

src_install() {
	default
	newicon icons/ltris48.xpm ${PN}.xpm
	make_desktop_entry ltris LTris
	prepgamesdirs
}

pkg_preinst() {
	gnome2_icon_savelist
	games_pkg_preinst
}

pkg_postinst() {
	gnome2_icon_cache_update
	games_pkg_postinst
}

pkg_postrm() {
	gnome2_icon_cache_update
}
