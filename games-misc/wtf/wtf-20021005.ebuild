# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/wtf/wtf-20021005.ebuild,v 1.5 2004/03/10 17:28:17 vapier Exp $

inherit games

DESCRIPTION="translates acronyms for you"
HOMEPAGE="http://www.mu.org/~mux/wtf/"
SRC_URI="http://www.mu.org/~mux/wtf/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha hppa amd64"

DEPEND=">=sys-apps/sed-4"
RDEPEND="sys-apps/grep"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "s:/usr/local/share/misc:${GAMES_DATADIR}/${PN}:" \
		${S}/wtf \
		|| die "sed wtf failed"
}

src_install() {
	dogamesbin wtf || die "dogamesbin failed"
	doman wtf.6
	insinto ${GAMES_DATADIR}/${PN}
	doins acronyms || die "doins failed"
	prepgamesdirs
}
