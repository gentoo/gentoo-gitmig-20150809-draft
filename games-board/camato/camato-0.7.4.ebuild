# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/camato/camato-0.7.4.ebuild,v 1.1 2006/10/12 16:46:29 nyhm Exp $

inherit versionator games

MY_PV=$(replace_all_version_separators _)
DESCRIPTION="A map editor for the game gnocatan"
HOMEPAGE="http://yusei.ragondux.com/loisirs_jdp_catane_camato-en.html"
SRC_URI="http://yusei.ragondux.com/files/gnocatan/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="dev-ruby/ruby-gtk2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f Makefile
	sed -i "s:/usr/share:${GAMES_DATADIR}:" \
		${PN} || die "sed failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r *.rb img || die "doins failed"
	dodoc ChangeLog README
	prepgamesdirs
}
