# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/tremulous/tremulous-1.1.0.ebuild,v 1.4 2006/12/05 18:03:48 wolf31o2 Exp $

inherit eutils toolchain-funcs games

DESCRIPTION="Team-based aliens vs humans FPS with buildable structures"
HOMEPAGE="http://tremulous.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip
	http://0day.icculus.org/mirrors/${PN}/${P}.zip
	ftp://ftp.wireplay.co.uk/pub/quake3arena/mods/${PN}/${P}.zip"

LICENSE="GPL-2
	CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="dedicated openal opengl vorbis"

UIDEPEND="openal? ( media-libs/openal )
	media-libs/libsdl
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext"
RDEPEND="opengl? ( ${UIDEPEND} )
	!opengl? ( !dedicated? ( ${UIDEPEND} ) )
	!games-fps/tremulous-bin"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}/${P}-src

pkg_setup() {
	games_pkg_setup

	if use amd64 ; then
		ewarn "emerge games-fps/tremulous-bin instead for better performance."
		echo
	fi
}

src_unpack() {
	unpack ${A}
	cd ${PN}

	unpack ./${P}-src.tar.gz
}

src_compile() {
	buildit() { use $1 && echo 1 || echo 0 ; }

	local build_client=1
	if use dedicated && ! use opengl ; then
		build_client=0
	fi

	emake \
		BUILD_CLIENT=${build_client} \
		BUILD_SERVER=$(buildit dedicated) \
		CC="$(tc-getCC)" \
		DEFAULT_BASEDIR="${GAMES_DATADIR}/${PN}" \
		USE_CODEC_VORBIS=$(buildit vorbis) \
		USE_OPENAL=$(buildit openal) \
		USE_LOCAL_HEADERS=0 \
		OPTIMIZE= \
		|| die "emake failed"
}

src_install() {
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r ../base || die "doins -r failed"

	dodoc ChangeLog ../manual.pdf

	local bindir=build/release-linux-${ARCH}

	if use opengl || ! use dedicated ; then
		newgamesbin ${bindir}/${PN}.${ARCH} ${PN} \
			|| die "newgamesbin client failed"
		doicon misc/${PN}.xpm
		make_desktop_entry ${PN} Tremulous ${PN}.xpm
	fi

	if use dedicated ; then
		newgamesbin ${bindir}/tremded.${ARCH} ${PN}-ded \
			|| die "newgamesbin ded failed"
	fi

	prepgamesdirs
}
