# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glest/glest-3.2.2.ebuild,v 1.10 2011/06/09 12:19:44 tupone Exp $

EAPI=2
inherit eutils autotools wxwidgets games

DESCRIPTION="Cross-platform 3D realtime strategy game"
HOMEPAGE="http://www.glest.org/"
SRC_URI="http://www.titusgames.de/${PN}-source-${PV}.tar.bz2
	mirror://sourceforge/glest/${PN}_data_3.2.1.zip
	mirror://gentoo/${P}-tutorial.tar.bz2"

LICENSE="GPL-2 glest-data"
SLOT="0"
KEYWORDS="~amd64 -ppc x86" # ppc: bug #145478
IUSE="editor"

RDEPEND="media-libs/libsdl[joystick,video]
	media-libs/libogg
	media-libs/libvorbis
	media-libs/openal
	|| ( >=dev-libs/xerces-c-3[icu] >=dev-libs/xerces-c-3[-icu,-iconv] )
	virtual/opengl
	virtual/glu
	dev-lang/lua
	x11-libs/libX11
	editor? ( x11-libs/wxGTK:2.8[X] )"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/ftjam"

S=${WORKDIR}/${PN}-source-${PV}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-xerces-c.patch \
		"${FILESDIR}"/${P}-underlink.patch \
		"${FILESDIR}"/${P}-glibc210.patch \
		"${FILESDIR}"/${P}-glibc212.patch

	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		glest_game/main/main.cpp \
		|| die "sed failed"

		sed -i \
		-e '/Lang/s:\.lng::' \
		glest.ini \
		|| die "sed failed"

	sed -i \
		-e 's:-O3 -DNDEBUG:-DNDEBUG:' \
		Jamrules \
		|| die "sed failed"

	find "${WORKDIR}"/glest_game -name Thumbs.db -exec rm -f '{}' +

	AT_M4DIR="mk/autoconf" eautoreconf
}

src_configure() {
	if use editor; then
		WX_GTK_VER=2.8
		need-wxwidgets unicode
	else
		NOWX="--with-wx-config=disabled_wx"
	fi

	egamesconf \
		--with-vorbis=/usr \
		--with-ogg=/usr \
		${NOWX}
}

src_compile() {
	local jamopts=$(echo "${MAKEOPTS}" | sed -ne "/-j/ { s/.*\(-j[[:space:]]*[0-9]\+\).*/\1/; p }")
	jam -dx -q ${jamopts} || die "jam failed"
}

src_install() {
	dogamesbin glest || die "dogamesbin glest failed"
	if use editor ; then
	    dogamesbin glest_editor || die "dogamesbin glest_editor failed"
	fi

	insinto "${GAMES_DATADIR}"/${PN}
	doins glest.ini || die "doins glest.ini failed"

	cd "${WORKDIR}"/glest_game
	doins -r servers.ini \
		data maps scenarios techs tilesets tutorials || die "doins data failed"
	dodoc docs/readme.txt || die "dodoc docs/readme.txt failed"

	newicon techs/magitech/factions/magic/units/archmage/images/archmage.bmp \
		${PN}.bmp || die "newicon failed"
	make_desktop_entry glest Glest /usr/share/pixmaps/${PN}.bmp
	prepgamesdirs
}
