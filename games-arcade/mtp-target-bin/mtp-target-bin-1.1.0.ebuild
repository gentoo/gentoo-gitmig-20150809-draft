# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/mtp-target-bin/mtp-target-bin-1.1.0.ebuild,v 1.1 2004/06/25 07:48:30 mr_bones_ Exp $

inherit games

MY_PN=${PN/-bin}
DESCRIPTION="a Monkey Target clone (six mini-game from Super Monkey Ball)"
HOMEPAGE="http://www.mtp-target.org/"
SRC_URI="http://mtptarget.free.fr/download/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/STLport
	sys-libs/zlib
	dev-libs/libxml2
	virtual/x11
	virtual/opengl
	=media-libs/freetype-2*
	media-libs/jpeg
	=dev-lang/lua-5*"

S="${WORKDIR}/${MY_PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	find . -type d -name CVS -print0 | xargs -0 rm -rf
	sed "s:GENTOODIR:${GAMES_PREFIX_OPT}/${PN}:" \
		"${FILESDIR}/${PN}.sh" > "${T}/${PN}-client" \
		|| die "sed failed"
}

src_install() {
	rm -f {client,server}/launch.sh

	dodir "${GAMES_PREFIX_OPT}/${PN}"
	cp -a "${S}/"* "${D}${GAMES_PREFIX_OPT}/${PN}/"

	into "${GAMES_PREFIX_OPT}"
	dobin "${T}/${PN}-client"
	dosym ${PN}-client "${GAMES_PREFIX_OPT}/bin/${PN}-server"

	dosym /usr/lib/liblualib.so "${GAMES_PREFIX_OPT}/${PN}/lib/liblualib50.so.5.0"
	dosym /usr/lib/liblua.so "${GAMES_PREFIX_OPT}/${PN}/lib/liblua50.so.5.0"
	prepgamesdirs
}
