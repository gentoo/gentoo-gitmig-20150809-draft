# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/scorched3d/scorched3d-39.1.ebuild,v 1.5 2006/04/17 13:30:05 wolf31o2 Exp $

inherit wxwidgets games

DESCRIPTION="Multi-player tank battle in 3D (OpenGL)"
HOMEPAGE="http://www.scorched3d.co.uk/"
SRC_URI="mirror://sourceforge/scorched3d/Scorched3D-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="mysql"

DEPEND="virtual/opengl
	>=media-libs/openal-20050504
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2.5
	=x11-libs/wxGTK-2.4*
	>=media-libs/freetype-2
	mysql? ( dev-db/mysql )"

S=${WORKDIR}/scorched

pkg_setup() {
	games_pkg_setup
	need-wxwidgets gtk2 || die "You need to emerge wxGTK with USE='gtk2'"
}

src_compile() {
	# work around portage bug: described in bug #73527
	need-wxwidgets gtk2 || die "You need to emerge wxGTK with USE='gtk2'"
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
	insinto "${GAMES_DATADIR}/scorched3d/data/globalmods/apoc/data/textures/explode/"
	doins "${FILESDIR}/smoke-orange.bmp" || die "doins failed" #bug #105237
	prepgamesdirs
}
