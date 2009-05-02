# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/powwow/powwow-1.2.15.ebuild,v 1.1 2009/05/02 15:27:06 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="PowWow Console MUD Client"
HOMEPAGE="http://hoopajoo.net/projects/powwow.html"
SRC_URI="http://hoopajoo.net/static/projects/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_configure() {
	egamesconf \
		--disable-dependency-tracking \
		--includedir=/usr/include
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog Config.demo Hacking NEWS README.* TODO
	prepgamesdirs
}
