# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pingus/pingus-0.6.0-r1.ebuild,v 1.3 2004/02/03 20:51:56 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="free Lemmings clone"
HOMEPAGE="http://pingus.seul.org/"
SRC_URI="http://pingus.seul.org/files/${P}.tar.bz2"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="opengl"

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
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	# pos install process ... FIXME
	mv ${D}/usr/games/{games,bin}
	cd ${D}/usr/share/games
	mv locale ../
	mv games/pingus .
	rm -rf games
	# end pos install process
	prepgamesdirs
}
