# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/yadex/yadex-1.7.0.ebuild,v 1.7 2006/06/25 00:12:34 mr_bones_ Exp $

inherit games

DESCRIPTION="A Doom level (wad) editor"
HOMEPAGE="http://www.teaser.fr/~amajorel/yadex/"
SRC_URI="http://www.teaser.fr/~amajorel/yadex/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""
RESTRICT="test"

DEPEND="|| ( x11-libs/libX11 virtual/x11 )"

src_unpack() {
	unpack ${A}
	sed -i \
		-e '/iwad/s/local\///' \
		"${S}"/yadex.cfg \
		|| die "sed yadex.cfg failed"
	epatch "${FILESDIR}/${P}"-NULL-is-not-zero.patch
	# Force the patched file to be old, otherwise the compile fails
	touch -t 196910101010 "${S}"/src/wadlist.cc
}

src_compile() {
	# not an autoconf script
	./configure --prefix="/usr" || die "configure failed"
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin obj/0/yadex || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}/${PV}"
	doins ygd/* || die "doins failed (data)"
	doman doc/yadex.6
	dodoc CHANGES FAQ README TODO VERSION
	dohtml doc/*
	insinto /etc/yadex/${PV}
	doins yadex.cfg || die "doins failed (cfg)"
	prepgamesdirs
}
