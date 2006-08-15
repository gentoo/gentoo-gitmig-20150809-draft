# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pengupop/pengupop-2.1.4.ebuild,v 1.4 2006/08/15 21:35:20 wormo Exp $

inherit eutils games

DESCRIPTION="Networked multiplayer-only Puzzle Bubble clone"
HOMEPAGE="http://www.junoplay.com/pengupop"
SRC_URI="http://www.junoplay.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	insinto /usr/share/applications
	doins pengupop.desktop || die "doins failed"
	doicon pengupop.png
	prepgamesdirs
}
