# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/glest/glest-1.0.10_p7.ebuild,v 1.1 2005/04/10 04:42:43 vapier Exp $

inherit eutils games

DATAVERSION="${PV/_p?/}"
SOURCEVERSION="${PV/_p/-r}"
DESCRIPTION="Cross-platform 3D realtime strategy game"
HOMEPAGE="http://www.stud.uni-karlsruhe.de/~uxsm/glest/"
SRC_URI="http://www.stud.uni-karlsruhe.de/~uxsm/glest-${SOURCEVERSION}-source.tar.bz2
	http://www.stud.uni-karlsruhe.de/~unatc/glest/glest-${DATAVERSION}-data.tar.bz2
	linguas_de? ( http://www.stud.uni-karlsruhe.de/~uxsm/german.lng )
	linguas_ru? ( http://www.stud.uni-karlsruhe.de/~uxsm/russian.lng )
	linguas_dk? ( http://www.stud.uni-karlsruhe.de/~uxsm/dansk.lng )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.5
	media-libs/libogg
	media-libs/libvorbis
	>=media-libs/openal-20040303
	dev-libs/xerces-c
	virtual/opengl
	virtual/x11"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2
	>=dev-util/jam-2.5"

S=${WORKDIR}/${PN}-${DATAVERSION}

src_unpack() {
	unpack glest-${SOURCEVERSION}-source.tar.bz2 glest-${DATAVERSION}-data.tar.bz2
	cd "${S}"
	# sometimes they package configure, sometimes they dont
	if [[ ! -e configure ]] ; then
		./autogen.sh || die "autogen failed"
	fi
}

src_compile() {
	egamesconf || die
	jam || die "jam failed"
}

src_install() {
	dogamesbin "${FILESDIR}"/glest || die "couldn't install launcher"
	dosed "s:GENTOO_DATADIR:${GAMES_DATADIR}:" "${GAMES_BINDIR}"/glest

	dodir "${GAMES_DATADIR}/${PN}"
	cp -r Tech data map tileset "${D}/${GAMES_DATADIR}"/${PN}/ || die "data copy failed"
	insinto "${GAMES_DATADIR}"/${PN}/config
	doins glest.ini || die "config copy failed"
	insinto "${GAMES_DATADIR}/${PN}"/lib
	doins out/*-linux-gnu/opt/lib/sources/libglestlib.a || die "doins lib.a failed"
	exeinto "${GAMES_DATADIR}/${PN}"/lib
	doexe glest || die "doexe failed"

	use linguas_de && cp "${DISTDIR}"/german.lng "${D}/${GAMES_DATADIR}"/${PN}/data/lang/
	use linguas_ru && cp "${DISTDIR}"/russian.lng "${D}/${GAMES_DATADIR}"/${PN}/data/lang/
	use linguas_dk && cp "${DISTDIR}"/dansk.lng "${D}/${GAMES_DATADIR}"/${PN}/data/lang/

	make_desktop_entry glest Glest

	prepgamesdirs
}
