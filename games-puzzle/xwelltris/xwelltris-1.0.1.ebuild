# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/xwelltris/xwelltris-1.0.1.ebuild,v 1.12 2006/06/29 16:22:25 wolf31o2 Exp $

inherit games

DESCRIPTION="tetris like popular game"
HOMEPAGE="http://xnc.dubna.su/xwelltris/"
SRC_URI="http://xnc.dubna.su/xwelltris/src/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="sdl"

RDEPEND="|| (
	(
		x11-misc/xbitmaps
		x11-proto/xproto
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXmu
		x11-libs/libXaw )
	virtual/x11 )
	sdl? (
		media-libs/libsdl
		media-libs/sdl-image )"
DEPEND="${RDEPEND}
	|| (
		x11-libs/libX11
		virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/INSTALL_PROGRAM/s/-s //' src/Make.common.in || die "sed failed"
}

src_compile() {
	# configure/build process is pretty messed up
	egamesconf $(use_with sdl) || die "egamesconf failed"
	sed -i \
		-e "/GLOBAL_SEARCH/s:\".*\":\"${GAMES_DATADIR}/${PN}\":" \
			src/include/globals.h \
			|| die "sed src/include/globals.h failed"
	emake || die "emake failed"
}

src_install() {
	dodir "${GAMES_BINDIR}" "${GAMES_DATADIR}/${PN}" /usr/share/man
	make install \
		INSTDIR="${D}/${GAMES_BINDIR}" \
		INSTLIB="${D}/${GAMES_DATADIR}/${PN}" \
		INSTMAN=/usr/share/man \
		|| die "make install failed"
	dodoc AUTHORS Changelog README*
	prepgamesdirs
}
