# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/clanbomber/clanbomber-1.05.ebuild,v 1.1 2004/02/17 02:54:55 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Bomberman-like multiplayer game"
HOMEPAGE="http://clanbomber.sourceforge.net/"
SRC_URI="mirror://sourceforge/clanbomber/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="sys-libs/zlib
	media-libs/hermes
	=dev-games/clanlib-0.6.5*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

pkg_setup() {
	clanlib-config 0.6.5
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:\(@datadir@/clanbomber/\):$(DESTDIR)\1:' \
		clanbomber/{,*/}Makefile.in \
			|| die "sed failed"
	epatch "${FILESDIR}/${PV}-no-display.patch"
}

src_compile() {
	egamesconf || die
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog IDEAS QUOTES README TODO || die "dodoc failed"
	prepgamesdirs
}
