# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/clanbomber/clanbomber-1.05.ebuild,v 1.4 2004/12/08 09:33:33 mr_bones_ Exp $

inherit games eutils flag-o-matic

DESCRIPTION="Bomberman-like multiplayer game"
HOMEPAGE="http://clanbomber.sourceforge.net/"
SRC_URI="mirror://sourceforge/clanbomber/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND="sys-libs/zlib
	media-libs/hermes
	=dev-games/clanlib-0.6.5*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:\(@datadir@/clanbomber/\):$(DESTDIR)\1:' \
		clanbomber/{,*/}Makefile.in \
		|| die "sed failed"
	epatch "${FILESDIR}/${PV}-no-display.patch"
	epatch "${FILESDIR}/${PV}-gcc34.patch"
}

src_compile() {
	append-flags -I${ROOT}/usr/include/clanlib-0.6.5
	append-ldflags -L${ROOT}/usr/lib/clanlib-0.6.5
	egamesconf || die
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog IDEAS QUOTES README
	prepgamesdirs
}
