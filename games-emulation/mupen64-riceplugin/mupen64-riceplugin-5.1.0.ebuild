# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mupen64-riceplugin/mupen64-riceplugin-5.1.0.ebuild,v 1.10 2006/06/01 18:51:02 tupone Exp $

inherit toolchain-funcs eutils libtool flag-o-matic games

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

S="${WORKDIR}/riceplugin"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-makefile.patch \
		"${FILESDIR}"/${PN}-gtk2.patch \
		"${FILESDIR}"/${PN}-compile.patch \
		"${FILESDIR}"/${PN}-gcc4.patch
}

src_compile() {
	[[ $(gcc-major-version) -ge 4 ]] && ! is-flag -msse && append-flags -msse
	emake || die "emake failed"
}

src_install() {
	exeinto "${GAMES_LIBDIR}"/mupen64/plugins
	doexe *.so
	insinto "${GAMES_LIBDIR}"/mupen64/plugins
	doins *.ini
	prepgamesdirs
}
