# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/scorched3d/scorched3d-37.2.ebuild,v 1.3 2004/07/04 09:59:14 mr_bones_ Exp $

inherit games

DESCRIPTION="Multi-player tank battle in 3D (OpenGL)"
HOMEPAGE="http://www.scorched3d.co.uk/"
SRC_URI="mirror://sourceforge/scorched3d/Scorched3D-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="mysql"

RDEPEND=">=media-libs/libsdl-1.0.1
	media-libs/sdl-net
	media-libs/sdl-mixer
	>=x11-libs/wxGTK-2.3.4
	dev-games/ode
	>=sys-libs/zlib-1.1.4
	mysql? ( dev-db/mysql )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/scorched"

pkg_setup() {
	if wx-config --cppflags | grep gtk2u >& /dev/null; then
		einfo "${PN} will not build if wxGTK was compiled"
		einfo "with unicode support.  If you are using a version of"
		einfo "wxGTK <= 2.4.2, you must set USE=-gtk2.  In newer versions,"
		einfo "you must set USE=-unicode."
		die "wxGTK must be re-emerged without unicode suport"
	fi
}

src_compile() {
	egamesconf \
		--exec_prefix="${GAMES_PREFIX}" \
		--datadir="${GAMES_DATADIR}/${PN}" \
		$(use_with mysql) \
		|| die
	sed -i \
		-e "s:/usr/games/scorched3d/:${GAMES_DATADIR}/${PN}/:" \
		src/scorched/Makefile \
			|| die "sed src/scorched/Makefile failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin src/scorched/scorched3d || die "dogamesbin failed"
	dodoc AUTHORS README TODO documentation/*.txt
	dodir "${GAMES_DATADIR}/${PN}"
	cp -R data/ "${D}${GAMES_DATADIR}/${PN}" || die "cp failed (data)"
	cp README "${D}${GAMES_DATADIR}/${PN}" || die "cp failed (README)"
	dodir "${GAMES_DATADIR}/${PN}/documentation"
	cp -r documentation/html "${D}${GAMES_DATADIR}/${PN}/documentation"
	prepgamesdirs
}
