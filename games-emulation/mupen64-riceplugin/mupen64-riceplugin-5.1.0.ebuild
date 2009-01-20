# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-riceplugin/mupen64-riceplugin-5.1.0.ebuild,v 1.12 2009/01/20 10:41:01 tupone Exp $

inherit toolchain-funcs eutils flag-o-matic games

DESCRIPTION="an graphics plugin for mupen64"
SRC_URI="http://mupen64.emulation64.com/files/0.4/riceplugin.tar.bz2"
HOMEPAGE="http://mupen64.emulation64.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="sys-libs/zlib
	=x11-libs/gtk+-2*
	media-libs/libsdl
	virtual/glu
	virtual/opengl"
DEPEND="${RDEPEND}
	dev-lang/nasm"

S=${WORKDIR}/riceplugin

src_unpack() {
	unpack ${A}
	cd "${S}"
	edos2unix DLParser.h ROM.h
	epatch \
		"${FILESDIR}"/${PN}-makefile.patch \
		"${FILESDIR}"/${PN}-gtk2.patch \
		"${FILESDIR}"/${PN}-compile.patch \
		"${FILESDIR}"/${PN}-gcc4.patch \
		"${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	[[ $(gcc-major-version) -ge 4 ]] && ! is-flag -msse && append-flags -msse
	emake || die "emake failed"
}

src_install() {
	exeinto "$(games_get_libdir)"/mupen64/plugins
	doexe *.so || die "doexe failed"
	insinto "$(games_get_libdir)"/mupen64/plugins
	doins *.ini || die "doins failed"
	prepgamesdirs
}
