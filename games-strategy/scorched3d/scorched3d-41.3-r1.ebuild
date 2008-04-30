# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/scorched3d/scorched3d-41.3-r1.ebuild,v 1.2 2008/04/30 15:13:33 nyhm Exp $

inherit eutils wxwidgets games

DESCRIPTION="Multi-player tank battle in 3D (OpenGL)"
HOMEPAGE="http://www.scorched3d.co.uk/"
SRC_URI="mirror://sourceforge/${PN}/Scorched3D-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated mysql"

DEPEND="media-libs/libsdl
	media-libs/sdl-net
	media-libs/libpng
	media-libs/jpeg
	!dedicated? (
		virtual/opengl
		virtual/glu
		media-libs/libogg
		media-libs/libvorbis
		media-libs/openal
		media-libs/freealut
		=x11-libs/wxGTK-2.8*
		>=media-libs/freetype-2
		>=sci-libs/fftw-3
	)
	mysql? ( virtual/mysql )"

S=${WORKDIR}/scorched

pkg_setup() {
	games_pkg_setup
	if ! use dedicated ; then
		WX_GTK_VER="2.8" need-wxwidgets unicode
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--with-fftw=/usr \
		--with-ogg=/usr \
		--with-vorbis=/usr \
		--datadir="${GAMES_DATADIR}/${PN}" \
		--with-docdir="/usr/share/doc/${PF}" \
		--with-wx-config="${WX_CONFIG}" \
		--without-pgsql \
		$(use_with mysql) \
		$(use_enable dedicated serveronly) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if ! use dedicated ; then
		newicon data/windows/tank.bmp ${PN}.bmp
		make_desktop_entry ${PN} "Scorched 3D" /usr/share/pixmaps/${PN}.bmp
	fi
	prepgamesdirs
}
