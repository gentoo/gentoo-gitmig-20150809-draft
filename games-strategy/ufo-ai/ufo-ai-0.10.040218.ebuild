# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo-ai/ufo-ai-0.10.040218.ebuild,v 1.18 2006/12/06 21:06:04 wolf31o2 Exp $

inherit eutils flag-o-matic games

DESCRIPTION="UFO: Alien Invasion - X-COM inspired strategy game"
HOMEPAGE="http://www.ufoai.net/"
SRC_URI="http://n.ethz.ch/student/dbeyeler/download/ufoai_source_040218.zip
	http://people.ee.ethz.ch/~baepeter/linux_ufoaidemo.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	media-libs/jpeg
	media-libs/libvorbis"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	media-libs/libogg
	virtual/opengl
	virtual/glu
	app-arch/unzip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd source/linux
	epatch "${FILESDIR}"/${PV}-Makefile.patch
}

src_compile() {
	filter-flags -fstack-protector #51116
	cd "${S}"/source/linux
	emake build_release \
		OPTCFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dodir "${GAMES_DATADIR}/${PN}"
	cp -rf "${S}"/ufo/* "${D}${GAMES_DATADIR}/${PN}" || die "cp failed"
	if use x86 ; then
		ARCH=i386
	fi
	exeinto "${GAMES_DATADIR}/${PN}"
	doexe "${S}"/source/linux/release${ARCH}-glibc/{ref_gl.so,ref_glx.so,ufo} \
		|| die "doexe ufo"
	exeinto "${GAMES_DATADIR}/${PN}/base"
	doexe "${S}"/source/linux/release${ARCH}-glibc/game${ARCH}.so \
		|| die "doexe game${ARCH}.so"
	games_make_wrapper ufo-ai ./ufo "${GAMES_DATADIR}/${PN}"
	prepgamesdirs
}
