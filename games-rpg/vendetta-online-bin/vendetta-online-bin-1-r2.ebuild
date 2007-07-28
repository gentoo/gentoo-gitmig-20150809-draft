# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/vendetta-online-bin/vendetta-online-bin-1-r2.ebuild,v 1.1 2007/07/28 00:25:51 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="Space-based MMORPG with amazing graphics"
HOMEPAGE="http://www.vendetta-online.com/"
SRC_URI="x86? ( http://mirror.cle.vendetta-online.com/vendetta-linux-ia32-installer.sh
		http://mirror.milw.vendetta-online.com/vendetta-linux-ia32-installer.sh )
	amd64? ( http://mirror.cle.vendetta-online.com/vendetta-linux-amd64-installer.sh
		http://mirror.milw.vendetta-online.com/vendetta-linux-amd64-installer.sh )"

LICENSE="guild"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="virtual/opengl
	>=x11-libs/gtk+-2"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	dogamesbin vendetta || die "dogamesbin failed"
	prepgamesdirs
}
