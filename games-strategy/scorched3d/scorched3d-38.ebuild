# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/scorched3d/scorched3d-38.ebuild,v 1.2 2004/12/06 08:41:24 mr_bones_ Exp $

inherit wxwidgets games

DESCRIPTION="Multi-player tank battle in 3D (OpenGL)"
HOMEPAGE="http://www.scorched3d.co.uk/"
SRC_URI="mirror://sourceforge/scorched3d/Scorched3D-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="mysql gtk2"

DEPEND=">=media-libs/libsdl-1.0.1
	media-libs/sdl-net
	media-libs/sdl-mixer
	>=x11-libs/wxGTK-2.3.4
	media-libs/freetype
	>=sys-libs/zlib-1.1.4
	mysql? ( dev-db/mysql )"

S="${WORKDIR}/scorched"

pkg_setup() {
	if ! use gtk2; then
		need-wxwidgets gtk || die "No gtk1 version of x11-libs/wxGTK found"
	else
		need-wxwidgets gtk2 || die "You need to emerge wxGTK with USE='gtk2'"
	fi
	games_pkg_setup
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--exec_prefix="${GAMES_PREFIX}" \
		--datadir="${GAMES_DATADIR}/${PN}" \
		--with-docdir="/usr/share/doc/${PF}" \
		$(use_with mysql) \
		|| die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	prepgamesdirs
}
