# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/scorched3d/scorched3d-40.1d.ebuild,v 1.6 2007/09/28 23:52:49 dirtyepic Exp $

inherit eutils wxwidgets games

DESCRIPTION="Multi-player tank battle in 3D (OpenGL)"
HOMEPAGE="http://www.scorched3d.co.uk/"
SRC_URI="mirror://sourceforge/${PN}/Scorched3D-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="mysql"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libogg
	media-libs/libvorbis
	media-libs/openal
	media-libs/freealut
	media-libs/libsdl
	media-libs/sdl-net
	=x11-libs/wxGTK-2.6*
	>=media-libs/freetype-2
	mysql? ( virtual/mysql )"

S=${WORKDIR}/scorched

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-freealut.patch
}

pkg_setup() {
	games_pkg_setup
	WX_GTK_VER="2.6" need-wxwidgets unicode
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir="${GAMES_DATADIR}/${PN}" \
		--with-docdir="/usr/share/doc/${PF}" \
		--with-wx-config="${WX_CONFIG}" \
		$(use_with mysql) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon data/windows/tank.bmp ${PN}.bmp
	make_desktop_entry ${PN} "Scorched 3D" /usr/share/pixmaps/${PN}.bmp
	prepgamesdirs
}
