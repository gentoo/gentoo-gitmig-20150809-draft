# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo-ai/ufo-ai-0.10.040218.ebuild,v 1.15 2004/11/03 00:33:52 vapier Exp $

inherit eutils games flag-o-matic

DESCRIPTION="UFO: Alien Invasion - X-COM inspired strategy game"
HOMEPAGE="http://www.ufoai.net/"
SRC_URI="http://n.ethz.ch/student/dbeyeler/download/ufoai_source_040218.zip
	http://people.ee.ethz.ch/~baepeter/linux_ufoaidemo.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="virtual/libc
	virtual/x11
	media-libs/jpeg
	media-libs/libvorbis
	media-libs/libogg"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd source/linux
	epatch "${FILESDIR}/${PV}-Makefile.patch"
}

src_compile() {
	filter-flags -fstack-protector #51116
	cd "${S}/source/linux"
	emake build_release \
		OPTCFLAGS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dodir "${GAMES_DATADIR}/${PN}"
	cp -rf "${S}/ufo/"* "${D}${GAMES_DATADIR}/${PN}" || die "copying data"
	if use x86 ; then
		ARCH=i386
	fi
	exeinto "${GAMES_DATADIR}/${PN}"
	doexe "${S}/source/linux/release${ARCH}-glibc/"{ref_gl.so,ref_glx.so,ufo} \
		|| die "doexe ufo"
	exeinto "${GAMES_DATADIR}/${PN}/base"
	doexe "${S}/source/linux/release${ARCH}-glibc/game${ARCH}.so" \
		|| die "doexe game${ARCH}.so"
	games_make_wrapper ufo-ai ./ufo "${GAMES_DATADIR}/${PN}"
	prepgamesdirs
}
