# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xkobo/xkobo-1.11.ebuild,v 1.5 2004/04/22 04:50:51 mr_bones_ Exp $

inherit games

MY_P="${P}+w01"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A fastpaced multiway scrolling shoot-em-up"
HOMEPAGE="http://freshmeat.net/projects/xkobo/?topic_id=80"
SRC_URI="http://www.redhead.dk/download/pub/Xkobo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc amd64"
IUSE=""

RDEPEND="virtual/glibc
	virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -e "s:/usr/local/games/xkobo-scores:${GAMES_STATEDIR}/xkobo-scores:" \
		xkobo.man > xkobo.6 \
		|| die 'sed xkobo.man failed'
	sed -i \
		-e "/HSCORE_DIR/ { s:/usr/local/games/xkobo-scores:${GAMES_STATEDIR}/xkobo-scores: }" \
		Imakefile \
		|| die 'sed Imakefile failed'
	xmkmf -a || die "xmkmf failed"
}

src_compile() {
	emake \
		CXXOPTIONS="${CXXFLAGS}" \
		CDEBUGFLAGS="${CFLAGS}" \
		xkobo || die "emake failed"
}

src_install() {
	dogamesbin xkobo || die "dogamesbin failed"
	doman xkobo.6
	keepdir "${GAMES_STATEDIR}/xkobo-scores"
	prepgamesdirs
	fperms 2775 "${GAMES_STATEDIR}/xkobo-scores"
}
