# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/triptych-demo/triptych-demo-0.ebuild,v 1.1 2004/12/08 04:33:58 vapier Exp $

inherit games eutils

DESCRIPTION="fast-paced tetris-like puzzler"
HOMEPAGE="http://www.chroniclogic.com/triptych.htm"
SRC_URI="http://www.chroniclogic.com/demo/triptych.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

RDEPEND="virtual/libc
	media-libs/libsdl
	virtual/x11
	virtual/opengl"

S=${WORKDIR}/triptych

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir} ${GAMES_BINDIR}

	cp -a * "${D}"/${dir}/
	games_make_wrapper triptych ./triptych ${dir}

	prepgamesdirs
}
