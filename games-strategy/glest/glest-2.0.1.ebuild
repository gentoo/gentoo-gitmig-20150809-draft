# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glest/glest-2.0.1.ebuild,v 1.2 2007/11/21 04:19:03 dirtyepic Exp $

inherit autotools eutils games

L_URI="http://www.glest.org/files/contrib/translations"
DESCRIPTION="Cross-platform 3D realtime strategy game"
HOMEPAGE="http://www.glest.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_source_${PV}.zip
	mirror://sourceforge/${PN}/${PN}_data_${PV}.zip
	linguas_de? ( ${L_URI}/deutsch_${PV}.zip )
	linguas_hu? ( ${L_URI}/magyar_${PV}.zip )"

LICENSE="GPL-2 glest-data"
SLOT="0"
KEYWORDS="~amd64 -ppc ~x86" # ppc: bug #145478
IUSE="linguas_de linguas_hu"

RDEPEND="media-libs/libsdl
	media-libs/libogg
	media-libs/libvorbis
	media-libs/openal
	dev-libs/xerces-c
	virtual/opengl
	virtual/glu
	x11-libs/libX11
	x11-libs/libXt
	media-fonts/font-adobe-utopia-75dpi"
DEPEND="${RDEPEND}
	app-arch/unzip
	|| ( dev-util/jam dev-util/ftjam )"

S=${WORKDIR}/mk/linux

GAMES_USE_SDL="nojoystick"

src_unpack() {
	unpack ${A}

	local file
	for file in $(find source mk -type f) ; do
		edos2unix "${file}"
	done

	epatch \
		"${FILESDIR}"/${P}-home.patch

	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		source/glest_game/main/main.cpp \
		|| die "sed main.cpp failed"

	cd "${S}"
	# sometimes they package configure, sometimes they don't
	if [[ ! -f configure ]] ; then
		chmod a+x autogen.sh
		./autogen.sh || die "autogen failed" # FIXME: use autotools.eclass
	fi

	sed -i 's:-O3 -g3::' Jamrules || die "sed Jamrules failed"
}

src_compile() {
	# Fails with wx enabled, bug #130011
	egamesconf \
		--with-vorbis=/usr \
		--with-ogg=/usr \
		--with-wx-config=disabled_wx \
		|| die
	jam -q || die "jam failed"
}

src_install() {
	dogamesbin glest || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins glest.ini || die "doins glest.ini failed"
	dodoc ../../docs/README.linux

	cd "${WORKDIR}"/glest_game
	doins -r data maps scenarios techs tilesets || die "doins data failed"
	dodoc docs/readme.txt

	make_desktop_entry glest Glest /usr/share/pixmaps/${PN}.bmp
	newicon techs/magitech/factions/magic/units/archmage/images/archmage.bmp \
		${PN}.bmp

	dolang() {
		insinto "${GAMES_DATADIR}"/${PN}/data/lang
		doins "${WORKDIR}"/${1} || die "doins ${1} failed"
	}

	use linguas_de && dolang deutsch.lng
	use linguas_hu && dolang magyar_${PV}.lng

	prepgamesdirs
}
