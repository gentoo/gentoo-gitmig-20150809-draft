# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glest/glest-2.0.0-r1.ebuild,v 1.1 2006/08/28 19:59:17 mr_bones_ Exp $

inherit eutils games

DV="${PV}"
LV="${PV}"
L_URI="http://www.glest.org/files/contrib/translations"

DESCRIPTION="Cross-platform 3D realtime strategy game"
HOMEPAGE="http://www.glest.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_source_${PV}.zip
	mirror://sourceforge/${PN}/${PN}_data_${DV}.zip
	linguas_fr? ( ${L_URI}/francais_${LV}.zip )
	linguas_it? ( ${L_URI}/italiano_${LV}.zip )
	linguas_pt_BR? ( ${L_URI}/portugues_${LV}.zip )
	linguas_sk? ( ${L_URI}/slovak_${LV}.zip )"

LICENSE="GPL-2 glest-data"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="linguas_fr linguas_it linguas_pt_BR linguas_sk"

RDEPEND=">=media-libs/libsdl-1.2.5
	media-libs/libogg
	media-libs/libvorbis
	media-libs/openal
	dev-libs/xerces-c
	virtual/opengl
	virtual/glu
	|| ( x11-libs/libX11 virtual/x11 )"
DEPEND="${RDEPEND}
	app-arch/unzip
	|| ( x11-libs/libXt virtual/x11 )
	>=dev-util/jam-2.5"

S=${WORKDIR}/${PN}_source_${PV}/mk/linux

src_unpack() {
	unpack ${A}

	local file
	for file in $(find ${PN}_source_${PV} -type f); do
		edos2unix "${file}"
	done

	epatch "${FILESDIR}/${P}"-gcc41.patch

	cd ${PN}_source_${PV}
	epatch "${FILESDIR}/${P}"-home.patch

	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}:" \
		source/glest_game/main/main.cpp \
		|| die "sed failed"

	cd "${S}"
	chmod a+x *.sh
	# sometimes they package configure, sometimes they dont
	if [[ ! -e configure ]] ; then
		./autogen.sh || die "autogen failed"
	fi

	sed -i \
		-e "/COMPILER_CFLAGS_optimize/s:-O3 -g3::" \
		-e "/COMPILER_C++FLAGS_optimize/s:-O3 -g3::" \
		Jamrules || die "sed flags failed"
}

src_compile() {
	# Fails with wx enabled, bug #130011
	egamesconf \
		--with-vorbis=/usr \
		--with-ogg=/usr \
		--with-wx-config=disabled_wx \
		|| die
	jam -q ${MAKEOPTS} || die "jam failed"
}

src_install() {
	dogamesbin glest || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins glest.ini || die "config copy failed"

	cd "${WORKDIR}"/glest_game
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r data maps techs tilesets || die "data copy failed"
	dodoc docs/readme.txt

	cd ..
	insinto "${GAMES_DATADIR}"/${PN}/data/lang
	if use linguas_fr ; then
		doins francais.lng || die "doins failed"
	fi
	if use linguas_it ; then
		doins italiano2_0_0.lng || die "doins failed"
	fi
	if use linguas_pt_BR ; then
		doins tradu_pt-br.lng || die "doins failed"
	fi
	if use linguas_sk ; then
		doins slovak.lng || die "doins failed"
	fi

	make_desktop_entry glest Glest

	prepgamesdirs
}
