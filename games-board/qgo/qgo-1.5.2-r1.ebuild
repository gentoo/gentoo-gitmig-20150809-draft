# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/qgo/qgo-1.5.2-r1.ebuild,v 1.1 2007/01/08 13:54:41 nyhm Exp $

inherit eutils qt3 games

DESCRIPTION="A Qt Go client and SGF editor"
HOMEPAGE="http://qgo.sourceforge.net/"
SRC_URI="mirror://sourceforge/qgo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="$(qt_min_version 3.3)"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i 's:$(datadir):/usr/share:' \
		templates/Makefile.in \
		|| die "sed Makefile.in failed"
	sed -i "s:/usr/share:${GAMES_DATADIR}:" \
		templates/*.desktop \
		|| die "sed .desktop failed"
	epatch "${FILESDIR}"/${P}-gatter.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
