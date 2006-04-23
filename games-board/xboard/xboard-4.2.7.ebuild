# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xboard/xboard-4.2.7.ebuild,v 1.9 2006/04/23 06:44:28 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="GUI for gnuchess and for internet chess servers"
HOMEPAGE="http://www.tim-mann.org/xboard.html"
SRC_URI="mirror://gnu/xboard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~ppc64 x86"
IUSE=""

DEPEND="games-board/gnuchess"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PV}-default-program.patch"
}

src_install() {
	egamesinstall || die
	dodoc FAQ READ_ME ToDo ChangeLog*
	dohtml FAQ.html
	prepgamesdirs
}
