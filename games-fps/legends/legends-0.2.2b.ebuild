# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/legends/legends-0.2.2b.ebuild,v 1.1 2003/09/26 15:52:31 vapier Exp $

inherit games

DESCRIPTION="A fast-paced first-person-perspective online multiplayer game"
HOMEPAGE="http://hosted.tribalwar.com/legends/"
SRC_URI="http://hosted.tribalwar.com/legends/files/legends.tar.gz"

LICENSE="TGE"
SLOT="0"
KEYWORDS="x86"

DEPEND=""
RDEPEND=">=media-libs/libsdl-1.2
	media-libs/openal"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	rm runlegends libSDL-*.so* libopenal.so
	find -type f -exec chmod a-x '{}' \;
	chmod -R a-x *
	chmod a+x common legends show ispawn lindedicated LinLegends
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}
	cp -R * ${D}/${dir}/
	dogamesbin ${FILESDIR}/legends
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/legends
	dogamesbin ${FILESDIR}/legends-ded
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/legends-ded
	prepgamesdirs
}
