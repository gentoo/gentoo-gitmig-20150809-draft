# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.6.0-r1.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

inherit games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.seul.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=media-libs/hermes-1.3.2-r2
	=dev-games/clanlib-0.6.5*
	>=dev-libs/libxml2-2.5.6"

pkg_setup() {
	clanlib-config 0.6.5
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc3.patch
}

src_compile() {
	egamesconf \
		--with-bindir=${GAMES_BINDIR} \
		--with-datadir=${GAMES_DATADIR_BASE} \
		`use_with opengl clanGL` \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	# pos install process ... FIXME
	mv ${D}/usr/games/{games,bin}
	cd ${D}/usr/share/games
	mv locale ../
	mv games/pingus .
	rm -rf games
	# end pos install process
	prepgamesdirs
}
