# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/clanbomber/clanbomber-1.04.ebuild,v 1.2 2004/01/10 21:28:16 vapier Exp $

inherit games flag-o-matic

DESCRIPTION="free (GPL) Bomberman-like multiplayer game"
HOMEPAGE="http://clanbomber.sourceforge.net/"
SRC_URI="mirror://sourceforge/clanbomber/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-libs/zlib
	media-libs/hermes
	=dev-games/clanlib-0.6.5*"

pkg_setup() {
	clanlib-config 0.6.5
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		's:\(@datadir@/clanbomber/\):$(DESTDIR)\1:' \
		clanbomber/{,*/}Makefile.in
}

src_compile() {
	egamesconf || die
	addpredict /dev/dsp
	emake -j1 || die
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog IDEAS QUOTES README TODO
}
