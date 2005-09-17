# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glest/glest-1.1.0.ebuild,v 1.2 2005/09/17 20:03:52 mr_bones_ Exp $

inherit eutils games

DATAVERSION="${PV/_p?/}"
SOURCEVERSION="${PV/_p/-r}"
DESCRIPTION="Cross-platform 3D realtime strategy game"
HOMEPAGE="http://www.glest.org/"
SRC_URI="mirror://sourceforge/glest/glest-source-${SOURCEVERSION}.tar.bz2
	mirror://sourceforge/glest/glest_data_v${DATAVERSION}.zip
	linguas_de? ( http://www.stud.uni-karlsruhe.de/~uxsm/german.lng )
	linguas_ru? ( http://www.stud.uni-karlsruhe.de/~uxsm/russian.lng )
	linguas_dk? ( http://www.stud.uni-karlsruhe.de/~uxsm/dansk.lng )"

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
	virtual/x11"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=sys-devel/gcc-3.2
	>=dev-util/jam-2.5"

S=${WORKDIR}/${PN}-${DATAVERSION}

src_unpack() {
	unpack glest-source-${SOURCEVERSION}.tar.bz2 glest_data_v${DATAVERSION}.zip
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fake-checkGlCaps.patch
	# sometimes they package configure, sometimes they dont
	if [[ ! -e configure ]] ; then
		./autogen.sh || die "autogen failed"
	fi
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

	if use linguas_de ; then
		cp "${DISTDIR}"/german.lng "${D}/${GAMES_DATADIR}"/${PN}/data/lang/ \
			|| die "cp failed"
	fi
	if use linguas_ru ; then
		cp "${DISTDIR}"/russian.lng "${D}/${GAMES_DATADIR}"/${PN}/data/lang/ \
			|| die "cp failed"
	fi
	if use linguas_dk ; then
		cp "${DISTDIR}"/dansk.lng "${D}/${GAMES_DATADIR}"/${PN}/data/lang/ \
			|| die "cp failed"
	fi

	make_desktop_entry glest Glest

	prepgamesdirs
}
