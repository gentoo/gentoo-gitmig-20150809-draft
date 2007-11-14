# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mednafen/mednafen-0.6.1.ebuild,v 1.7 2007/11/14 16:49:56 mr_bones_ Exp $

inherit games

DESCRIPTION="An advanced NES, GB/GBC/GBA, TurboGrafx 16/CD, and Lynx emulator"
HOMEPAGE="http://mednafen.sourceforge.net/"
SRC_URI="http://mednafen.com/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="virtual/opengl
	sys-libs/zlib
	media-libs/libsndfile
	dev-libs/libcdio
	>=media-libs/libsdl-1.2.0
	media-libs/sdl-net"

# The following likely still applies to Mednafen as it uses FCE Ultra code.
# Because of code generation bugs, FCEUltra now depends on a version
# of gcc greater than or equal to GCC 3.2.2.
DEPEND="${RDEPEND}
	>=sys-devel/gcc-3.2.2"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's:\$(datadir)/locale:/usr/share/locale:' \
		po/Makefile.in.in \
		intl/Makefile.in \
		src/Makefile.in \
		|| die "sed failed"
}

# v0.5.2 conf with --disable-nls fails to compile
src_compile() {
	egamesconf \
		--disable-dependency-tracking || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README NEWS TODO ChangeLog
	dohtml Documentation/*
	prepgamesdirs
}
