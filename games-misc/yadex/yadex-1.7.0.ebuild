# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/yadex/yadex-1.7.0.ebuild,v 1.1 2004/01/14 03:53:50 mr_bones_ Exp $

inherit games

DESCRIPTION="A Doom level (wad) editor"
HOMEPAGE="http://www.teaser.fr/~amajorel/yadex/"
SRC_URI="http://www.teaser.fr/~amajorel/yadex/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/iwad/s/local\///' ${S}/yadex.cfg \
			|| die "sed yadex.cfg failed"
}

src_compile() {
	# not an autoconf script
	./configure --prefix="/usr" || die "configure failed"
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin obj/0/yadex                || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}/${PV}/"
	doins ygd/*                           || die "doins failed (data)"
	doman doc/yadex.6                     || die "doman failed"
	dodoc CHANGES FAQ README TODO VERSION || die "dodoc failed"
	dohtml doc/*                          || die "dohtml failed"
	insinto /etc/yadex/${PV}/
	doins yadex.cfg                       || die "doins failed (cfg)"

	prepgamesdirs
}
