# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-engines/gargoyle/gargoyle-20060917-r1.ebuild,v 1.5 2009/06/04 13:31:07 ssuominen Exp $

inherit eutils

MY_PV="2006-09-17"
MY_P=${PN}-${MY_PV}
DESCRIPTION="Beautified Glk library and interactive fiction multi-interpreter"
HOMEPAGE="http://ccxvii.net/gargoyle/"
SRC_URI="http://ccxvii.net/gargoyle/download/${MY_P}-source.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=media-libs/freetype-2.1.9-r1
	>=x11-libs/gtk+-2.10.6
	>=dev-libs/glib-2.12.4-r1
	>=media-libs/jpeg-6b-r5
	>=media-libs/libpng-1.2.8
	>=sys-libs/zlib-1.2.3
	=media-libs/fmod-3*
	>=media-libs/sdl-sound-1.0.1-r1
	>=media-libs/sdl-mixer-1.2.7"

DEPEND="${RDEPEND}
	dev-util/ftjam
	app-arch/unzip"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	#Fix file named
	epatch "${FILESDIR}"/filename-friendliness-${PV}.patch

	#Fix level9 compilation
	epatch "${FILESDIR}"/level9-compilation-fix-${PV}.patch

	#Fix gtk+ detection
	sed -i \
		-e 's/"pkg-config freetype2 gtk+"/"pkg-config freetype2 gtk+-2.0"/' \
		Jamrules \
		|| die "sed failed"
}

src_compile() {
	jam || die "jam failed"
}

src_install() {
	dodoc garglk/TODO licenses/*
	insinto /etc
	newins garglk/garglk.ini garglk.ini

	#Should to copy garglk/garglk.ini to /etc/, but I don't know the syntax

	cd build/linux.release
	dolib garglk/libgarglk.so
	dobin \
		advsys/gargoyle-advsys agility/gargoyle-agility alan2/gargoyle-alan2 \
		alan3/gargoyle-alan3 garglk/gargoyle git/gargoyle-git \
		hugo/gargoyle-hugo level9/gargoyle-level9 scare/gargoyle-scare \
		tads/gargoyle-tadsr frotz/gargoyle-frotz magnetic/gargoyle-magnetic
}
