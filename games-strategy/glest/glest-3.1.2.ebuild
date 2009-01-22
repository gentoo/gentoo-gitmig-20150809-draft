# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glest/glest-3.1.2.ebuild,v 1.5 2009/01/22 18:53:35 mr_bones_ Exp $

EAPI=2
inherit autotools eutils games

L_URI="http://www.glest.org/files/contrib/translations"
DESCRIPTION="Cross-platform 3D realtime strategy game"
HOMEPAGE="http://www.glest.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-source-${PV}.tar.bz2
	mirror://sourceforge/${PN}/${PN}_data_${PV}.zip
	linguas_pt_BR? ( ${L_URI}/brazilian_${PV}.zip )
	linguas_cs? ( ${L_URI}/cesky_${PV}.zip )
	linguas_de? ( ${L_URI}/german_${PV}.zip )
	linguas_hu? ( ${L_URI}/magyar_${PV}.zip )
	linguas_no? ( ${L_URI}/norsk_${PV}.zip )
	linguas_ru? ( ${L_URI}/russian_${PV}.zip )
	linguas_tr? ( ${L_URI}/turkish_${PV}.zip )"

LICENSE="GPL-2 glest-data"
SLOT="0"
KEYWORDS="~amd64 -ppc ~x86" # ppc: bug #145478
IUSE="linguas_pt_BR linguas_cs linguas_de linguas_hu linguas_no linguas_ru
linguas_tr"

RDEPEND="|| ( media-libs/libsdl[joystick] <media-libs/libsdl-1.2.13-r1 )
	media-libs/libogg
	media-libs/libvorbis
	media-libs/openal
	<dev-libs/xerces-c-3
	virtual/opengl
	virtual/glu
	x11-libs/libX11
	media-fonts/font-adobe-utopia-75dpi"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/ftjam"

S="${WORKDIR}"/${PN}-source-${PV}

GAMES_USE_SDL="nojoystick"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-{home,gcc43}.patch

	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		glest_game/main/main.cpp \
		|| die "sed main.cpp failed"

	# sometimes they package configure, sometimes they don't
	if [[ ! -f configure ]] ; then
		chmod a+x autogen.sh
		./autogen.sh || die "autogen failed" # FIXME: use autotools.eclass
	fi

	sed -i 's:-O3 -g3::' Jamrules || die "sed Jamrules failed"
}

src_configure() {
	# Fails with wx enabled, bug #130011
	egamesconf \
		--with-vorbis=/usr \
		--with-ogg=/usr \
		--with-wx-config=disabled_wx
}

src_compile() {
	jam -q || die "jam failed"
}

src_install() {
	dogamesbin glest || die "dogamesbin glest failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins glest.ini || die "doins glest.ini failed"
	dodoc README.linux || die "dodoc README.linux failed"

	cd "${WORKDIR}"/glest_game
	doins -r servers.ini \
		glest_irc.url \
		glest_web.url \
		data maps scenarios techs tilesets || die "doins data failed"
	dodoc docs/readme.txt || die "dodoc docs/readme.txt failed"

	newicon techs/magitech/factions/magic/units/archmage/images/archmage.bmp \
		${PN}.bmp
	make_desktop_entry glest Glest /usr/share/pixmaps/${PN}.bmp

	dolang() {
		insinto "${GAMES_DATADIR}"/${PN}/data/lang
		doins "${WORKDIR}"/${1} || die "doins ${1} failed"
	}

	use linguas_pt_BR && dolang brazilian_${PV}.lng
	use linguas_cs && dolang cesky.lng
	use linguas_de && dolang german.lng
	use linguas_hu && dolang magyar.lng
	use linguas_no && dolang norsk.lng
	use linguas_ru && dolang russian.lng
	use linguas_tr && dolang turkish.lng

	prepgamesdirs
}
