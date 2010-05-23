# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/openarena/openarena-0.8.1-r1.ebuild,v 1.6 2010/05/23 21:25:31 pacho Exp $

EAPI=2
inherit eutils flag-o-matic versionator games

MY_PV=$(delete_all_version_separators)

DESCRIPTION="Open-source replacement for Quake 3 Arena"
HOMEPAGE="http://openarena.ws/"
SRC_URI="http://download.tuxfamily.org/openarena/rel/${MY_PV}/oa${MY_PV}.zip
	http://openarena.ws/svn/source/${MY_PV}/${PN}-engine-${PV}-1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+curl +openal +vorbis"

RDEPEND="virtual/opengl
	media-libs/libsdl[joystick,opengl,video]
	media-libs/speex
	media-libs/jpeg
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

src_prepare() {
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-unbundling.patch
	sed -i \
		-e '/ALDRIVER_DEFAULT/s/libopenal.so.0/libopenal.so/' \
		"${MY_S}"/code/client/snd_openal.c \
		|| die "sed failed"
	cd "${MY_S}"
	touch jpegint.h
}

src_compile() {
	local myopts

	# enable voip, disable mumble
	# also build always server and use smp by default
	myopts="USE_INTERNAL_SPEEX=0 USE_VOIP=1 USE_MUMBLE=0
		BUILD_SERVER=1 BUILD_CLIENT_SMP=1 USE_LOCAL_HEADERS=0"
	use curl || myopts="${myopts} USE_CURL=0"
	use openal || myopts="${myopts} USE_OPENAL=0"
	use vorbis || myopts="${myopts} USE_CODEC_VORBIS=0"

	cd "${MY_S}"
	emake \
		V=1 \
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
