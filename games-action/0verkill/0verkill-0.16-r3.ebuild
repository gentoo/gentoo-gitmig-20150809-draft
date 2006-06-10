# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/0verkill/0verkill-0.16-r3.ebuild,v 1.1 2006/06/10 12:49:56 vapier Exp $

inherit eutils games

DESCRIPTION="A bloody 2D action deathmatch-like game in ASCII-ART"
HOMEPAGE="http://artax.karlin.mff.cuni.cz/~brain/0verkill/"
SRC_URI="http://artax.karlin.mff.cuni.cz/~brain/0verkill/release/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="X"

DEPEND="X? ( || ( x11-libs/libXpm virtual/x11 ) )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-docs.patch
	epatch "${FILESDIR}"/${PV}-home-overflow.patch
	epatch "${FILESDIR}"/${PV}-gentoo-paths.patch
	epatch "${FILESDIR}"/${P}-underflow-check.patch #136222
	sed -i \
		-e "s:data/:${GAMES_DATADIR}/${PN}/data/:" cfg.h \
		|| die "sed failed"
	sed -i \
		-e "s:@CFLAGS@ -O3 :@CFLAGS@ :" Makefile.in \
		|| die "sed failed"
}

src_compile() {
	egamesconf $(use_with X x) || die
	emake || die "emake failed"
}

src_install() {
	local x
	dogamesbin 0verkill || die
	for x in avi bot editor server test_server ; do
		newgamesbin ${x} 0verkill-${x} || die ${x}
	done
	if use X ; then
		dogamesbin x0verkill || die
		for x in avi editor ; do
			newgamesbin ${x} 0verkill-${x} || die ${x}
		done
	fi

	insinto ${GAMES_DATADIR}/${PN}/data
	doins data/* || die
	insinto ${GAMES_DATADIR}/${PN}/grx
	doins grx/* || die

	dohtml doc/*.htm
	rm doc/*.html doc/README.OS2 doc/Readme\ Win32.txt doc/COPYING
	dodoc doc/*

	prepgamesdirs
}
