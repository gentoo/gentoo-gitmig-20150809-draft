# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/0verkill/0verkill-0.16-r1.ebuild,v 1.2 2004/01/06 02:52:51 avenj Exp $

inherit games eutils

DESCRIPTION="A bloody 2D action deathmatch-like game in ASCII-ART"
HOMEPAGE="http://artax.karlin.mff.cuni.cz/~brain/0verkill/"
SRC_URI="http://artax.karlin.mff.cuni.cz/~brain/0verkill/release/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="X"

RDEPEND="X? ( x11-base/xfree )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-docs.patch
	epatch ${FILESDIR}/${PV}-home-overflow.patch
	sed -i "s:data/:${GAMES_DATADIR}/${PN}/data/:" cfg.h
	sed -i "s:grx/:${GAMES_DATADIR}/${PN}/grx/:" data/*
}

src_compile() {
	egamesconf `use_with X x` || die
	emake || die
}

src_install() {
	dogamesbin 0verkill
	newgamesbin avi 0verkill-avi
	newgamesbin editor 0verkill-editor
	if [ `use X` ] ; then
		dogamesbin x0verkill
		newgamesbin xavi x0verkill-avi
		newgamesbin xeditor x0verkill-editor

	fi
	newgamesbin bot 0verkill-bot
	newgamesbin server 0verkill-server
	newgamesbin test_server 0verkill-test_server

	insinto ${GAMES_DATADIR}/${PN}/data
	doins data/*
	insinto ${GAMES_DATADIR}/${PN}/grx
	doins grx/*

	dohtml doc/*.htm
	rm doc/*.html doc/README.OS2 doc/Readme\ Win32.txt
	dodoc doc/*

	prepgamesdirs
}
