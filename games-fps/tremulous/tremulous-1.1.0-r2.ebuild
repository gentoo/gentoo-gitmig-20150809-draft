# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/tremulous/tremulous-1.1.0-r2.ebuild,v 1.1 2008/09/07 14:35:51 nyhm Exp $

EAPI=1

inherit eutils toolchain-funcs games

DESCRIPTION="Team-based aliens vs humans FPS with buildable structures"
HOMEPAGE="http://tremulous.net/"
SRC_URI="http://dl.trem-servers.com/${PN}-gentoopatches-${PV}-r5.zip
	http://dl.trem-servers.com/vms-1.1.t971.pk3
	http://0day.icculus.org/mirrors/${PN}/${P}.zip
	ftp://ftp.wireplay.co.uk/pub/quake3arena/mods/${PN}/${P}.zip
	mirror://sourceforge/${PN}/${P}.zip"

LICENSE="GPL-2 CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated openal +opengl +vorbis"

UIDEPEND="openal? ( media-libs/openal )
	media-libs/libsdl
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext"
RDEPEND="opengl? ( ${UIDEPEND} )
	!opengl? ( !dedicated? ( ${UIDEPEND} ) )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}/${P}-src

src_unpack() {
	unpack ${PN}-gentoopatches-${PV}-r5.zip
	unpack ${P}.zip

	cd ${PN}
	unpack ./${P}-src.tar.gz
	cp -f "${DISTDIR}"/vms-1.1.t971.pk3 "${WORKDIR}"/${PN}/base/ || die

	# security patches
	cd "${S}"
	epatch "${WORKDIR}"/${PN}-svn755-upto-971.patch
	epatch "${WORKDIR}"/${PN}-t971-client.patch
}

src_compile() {
	buildit() { use $1 && echo 1 || echo 0 ; }

	local client=1
	if ! use opengl; then
		client=0
		if ! use dedicated; then
			# user is not sure what he wants
			client=1
		fi
	fi

	emake \
		$(use amd64 && echo ARCH=x86_64) \
		BUILD_CLIENT=${client} \
		BUILD_SERVER=$(buildit dedicated) \
		BUILD_GAME_SO=0 \
		BUILD_GAME_QVM=0 \
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
	if use opengl || ! use dedicated ; then
		newgamesbin build/release-linux-*/${PN}.* ${PN} \
			|| die "newgamesbin ${PN}"
		newicon "${WORKDIR}"/tyrant.xpm ${PN}.xpm
		make_desktop_entry ${PN} Tremulous
	fi
	if use dedicated ; then
		newgamesbin build/release-linux-*/tremded.* ${PN}-ded \
			|| die "newgamesbin ${PN}-ded failed"
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "If you want to add extra maps, download"
	elog "http://tremulous.bricosoft.com/base/all-maps.tgz"
	elog "and unpack it into ~/.tremulous/base for your user"
	elog "or into ${GAMES_DATADIR}/${PN}/base for all users."
}
