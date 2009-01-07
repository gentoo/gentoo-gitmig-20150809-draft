# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/openarena/openarena-0.8.1.ebuild,v 1.1 2009/01/07 22:05:38 mr_bones_ Exp $

EAPI=1
inherit versionator games

MY_PV=$(delete_all_version_separators)

DESCRIPTION="Open-source replacement for Quake 3 Arena"
HOMEPAGE="http://openarena.ws/"
SRC_URI="http://download.tuxfamily.org/openarena/rel/${MY_PV}/oa${MY_PV}.zip
	http://openarena.ws/svn/source/${MY_PV}/${PN}-engine-${PV}-1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+curl +openal +vorbis"

RDEPEND="virtual/opengl
	media-libs/libsdl
	x11-libs/libXext
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	curl? ( net-misc/curl )
	openal? ( media-libs/openal )
	vorbis? ( media-libs/libvorbis )"
DEPEND="${RDEPEND}
	app-arch/unzip"

MY_S=${WORKDIR}/${PN}-engine-${PV}
BUILD_DIR=${PN}-build
DIR=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${P}-makefile.patch
	sed -i \
		-e "s:%CFLAGS%:${CFLAGS}:g" \
		"${MY_S}"/Makefile || die "seding cflags failed"
}

src_compile() {
	local myopts

	# use always internal speex and enable voip through it, disable mumble
	# also build always server and use smp by default
	myopts="USE_INTERNAL_SPEEX=1 USE_VOIP=1 USE_MUMBLE=0
		BUILD_SERVER=1 BUILD_CLIENT_SMP=1 USE_LOCAL_HEADERS=0"
	use curl || myopts="${myopts} USE_CURL=0"
	use openal || myopts="${myopts} USE_OPENAL=0"
	use vorbis || myopts="${myopts} USE_CODEC_VORBIS=0"

	cd "${MY_S}"
	emake \
		DEFAULT_BASEDIR="${DIR}" \
		BR="${BUILD_DIR}" \
		${myopts} \
		|| die "emake failed"
}

src_install() {
	cd "${MY_S}"/"${BUILD_DIR}"
	newgamesbin openarena-smp.* "${PN}" || die "binary install failed"
	newgamesbin oa_ded.* "${PN}-ded" || die "dedicated binary not found"
	cd "${S}"

	insinto "${DIR}"
	doins -r baseoa missionpack || die "doins -r failed"

	dodoc CHANGES CREDITS LINUXNOTES README
	newicon "${MY_S}"/misc/quake3.png ${PN}.png
	make_desktop_entry ${PN} "OpenArena"

	prepgamesdirs
}
