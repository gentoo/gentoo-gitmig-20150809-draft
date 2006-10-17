# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/scorched3d/scorched3d-40.ebuild,v 1.5 2006/10/17 15:26:29 wolf31o2 Exp $

inherit eutils wxwidgets games

DESCRIPTION="Multi-player tank battle in 3D (OpenGL)"
HOMEPAGE="http://www.scorched3d.co.uk/"
SRC_URI="mirror://sourceforge/${PN}/Scorched3D-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="mysql"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/libogg
	media-libs/libvorbis
	~media-libs/openal-0.0.8
	media-libs/freealut
	media-libs/libsdl
	media-libs/sdl-net
	>=x11-libs/wxGTK-2.6
	>=media-libs/freetype-2
	mysql? ( dev-db/mysql )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/scorched

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-freealut.patch
	epatch "${FILESDIR}"/${P}-unicode.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
}

pkg_setup() {
	games_pkg_setup
	WX_GTK_VER="2.6" \
	need-wxwidgets gtk2 || die "You need to emerge wxGTK with USE='X'"
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--exec_prefix="${GAMES_PREFIX}" \
		--datadir="${GAMES_DATADIR}/${PN}" \
		--with-docdir="/usr/share/doc/${PF}" \
		--with-wx-config="${WX_CONFIG}" \
		$(use_with mysql) \
		|| die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	prepgamesdirs
}
