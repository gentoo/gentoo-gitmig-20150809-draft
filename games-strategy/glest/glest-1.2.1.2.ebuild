# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glest/glest-1.2.1.2.ebuild,v 1.2 2006/02/23 22:36:20 tupone Exp $

inherit eutils games

DESCRIPTION="Cross-platform 3D realtime strategy game"
HOMEPAGE="http://www.glest.org/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_source_${PV}.zip
	mirror://sourceforge/${PN}/${PN}_data_${PV:0:5}.zip
	linguas_cs? (
	http://www.glest.org/files/additional/translations/cesky_${PV:0:5}.zip )
	linguas_he? (
	http://www.glest.org/files/additional/translations/hebrew_${PV:0:5}.zip	)
	linguas_sk? (
	http://www.glest.org/files/additional/translations/slovak_${PV:0:5}.zip	)"

LICENSE="GPL-2 glest-data"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.5
	media-libs/libogg
	media-libs/libvorbis
	>=media-libs/openal-20040303
	dev-libs/xerces-c
	virtual/opengl
	virtual/glu
	|| ( x11-libs/libX11 virtual/x11 )"
DEPEND="${RDEPEND}
	app-arch/unzip
	|| ( x11-libs/libXt virtual/x11 )
	>=sys-devel/gcc-3.2
	>=dev-util/jam-2.5"

S=${WORKDIR}/${PN}_source_${PV}/mk/linux

src_unpack() {
	unpack ${A}

	local file
	for file in $(find ${WORKDIR}/${PN}_source_${PV}/{source,mk} -type f); do
		edos2unix ${file}
	done

	cd "${S}"
	chmod a+x *.sh
	# sometimes they package configure, sometimes they dont
	if [[ ! -e configure ]] ; then
		./autogen.sh || die "autogen failed"
	fi
	#Our FLAGS
	sed -i \
		-e "/COMPILER_CFLAGS_optimize/s:-O3 -g3:${CFLAGS}:" \
		-e "/COMPILER_C++FLAGS_optimize/s:-O3 -g3:${CXXFLAGS}:" \
		Jamrules || die "sed failed"
}

src_compile() {
	egamesconf \
		--with-vorbis=/usr \
		--with-ogg=/usr \
		|| die
	jam || die "jam failed"
}

src_install() {
	dogamesbin "${FILESDIR}"/glest || die "couldn't install launcher"
	sed -i \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}:" \
		"${D}${GAMES_BINDIR}"/glest \
		|| die "sed failed"

	exeinto "${GAMES_DATADIR}"/${PN}/lib
	doexe glest || die "doexe failed"

	insinto "${GAMES_DATADIR}"/${PN}/config
	doins glest.ini || die "config copy failed"

	cd "${WORKDIR}"/glest_game
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r techs data maps tilesets || die "data copy failed"
	dodoc readme.txt

	if use linguas_cs ; then
		unpack cesky_${PV:0:5}.zip
		cp cesky_${PV:0:5}.lng "${D}/${GAMES_DATADIR}"/${PN}/data/lang/ \
			|| die "cp failed"
	fi
	if use linguas_he ; then
		unpack hebrew_${PV:0:5}.zip
		cp hebrew_${PV:0:5}.lng "${D}/${GAMES_DATADIR}"/${PN}/data/lang/ \
			|| die "cp failed"
	fi
	if use linguas_sk ; then
		unpack slovak_${PV:0:5}.zip
		cp slovak_${PV:0:5}.lng "${D}/${GAMES_DATADIR}"/${PN}/data/lang/ \
			|| die "cp failed"
	fi

	make_desktop_entry glest Glest

	prepgamesdirs
}
