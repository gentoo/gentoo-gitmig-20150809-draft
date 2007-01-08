# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/vendetta-online-bin/vendetta-online-bin-1-r1.ebuild,v 1.1 2007/01/08 17:48:07 nyhm Exp $

inherit eutils games

DESCRIPTION="Space-based MMORPG with amazing graphics"
HOMEPAGE="http://www.vendetta-online.com/"
SRC_URI="x86? ( vendetta-linux-installer.sh )
	amd64? ( vendetta-linux-amd64-installer.sh )"

LICENSE="guild"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch mirror strip"
QA_EXECSTACK="${GAMES_BINDIR:1}/vendetta"

RDEPEND="virtual/opengl
	=x11-libs/gtk+-1.2*"

S=${WORKDIR}

pkg_nofetch() {
	einfo "You need to download ${A} from"
	einfo "${HOMEPAGE} and copy it to"
	einfo "${DISTDIR}"
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dogamesbin vendetta || die "dogamesbin failed"
	prepgamesdirs
}
