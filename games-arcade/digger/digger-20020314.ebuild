# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/digger/digger-20020314.ebuild,v 1.12 2009/11/29 21:35:32 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Digger Remastered"
HOMEPAGE="http://www.digger.org/"
SRC_URI="http://www.digger.org/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl[video]"

src_compile() {
	emake -f Makefile.sdl || die
}

src_install() {
	dogamesbin digger || die "dogamesbin failed"
	dodoc digger.txt
	make_desktop_entry digger Digger
	prepgamesdirs
}
