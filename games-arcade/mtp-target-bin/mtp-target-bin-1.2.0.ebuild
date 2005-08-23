# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/mtp-target-bin/mtp-target-bin-1.2.0.ebuild,v 1.3 2005/08/23 19:00:52 wolf31o2 Exp $

inherit games

MY_PN=${PN/-bin}
DESCRIPTION="a Monkey Target clone (six mini-game from Super Monkey Ball)"
HOMEPAGE="http://www.mtp-target.org/"
SRC_URI="http://mtptarget.free.fr/download/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
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

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	find . -type d -name CVS -print0 | xargs -0 rm -r
}

src_install() {
	rm -f {client,server}/launch.sh

	dodir "${GAMES_PREFIX_OPT}/${PN}"
	cp -dpR "${S}/"* "${D}/${GAMES_PREFIX_OPT}"/${PN}/

	games_make_wrapper ${PN}-client ./client "${GAMES_PREFIX_OPT}/${PN}/client" ../lib
	games_make_wrapper ${PN}-server ./server "${GAMES_PREFIX_OPT}/${PN}/server" ../lib

	dosym /usr/lib/liblualib.so "${GAMES_PREFIX_OPT}"/${PN}/lib/liblualib50.so.5.0
	dosym /usr/lib/liblua.so "${GAMES_PREFIX_OPT}"/${PN}/lib/liblua50.so.5.0

	prepgamesdirs
	cd "${D}/${GAMES_PREFIX_OPT}"/${PN}
	cp client/mtp_target{_default,}.cfg || die "client cfg"
	cp server/mtp_target_service{_default,}.cfg || die "server cfg"
	chown ${GAMES_USER}:${GAMES_GROUP} client/mtp_target.cfg server/mtp_target_service.cfg
	chmod 660 client/mtp_target.cfg server/mtp_target_service.cfg
}
