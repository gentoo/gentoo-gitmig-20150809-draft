# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/qgo/qgo-1.5.4_p3.ebuild,v 1.3 2009/06/28 21:38:20 mr_bones_ Exp $

EAPI=2
inherit eutils qt3 games

DESCRIPTION="A Qt Go client and SGF editor"
HOMEPAGE="http://qgo.sourceforge.net/"
SRC_URI="mirror://sourceforge/qgo/${P/_p/-r}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-3.3:3"

S=${WORKDIR}/${P/_p*/}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-parallel.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	sed -i 's:$(datadir):/usr/share:' \
		templates/Makefile.in \
		|| die "sed Makefile.in failed"
	sed -i "s:/usr/share:${GAMES_DATADIR}:" \
		templates/*.desktop \
		|| die "sed .desktop failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "No go engines are emerged by default! If you want to play against"
	elog "the computer, you can emerge gnugo and configure ${PN} to use it."
}
