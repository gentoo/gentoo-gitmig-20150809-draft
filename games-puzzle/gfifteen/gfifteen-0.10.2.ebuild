# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gfifteen/gfifteen-0.10.2.ebuild,v 1.2 2012/04/07 04:08:27 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="graphical implementation of the sliding puzzle game fifteen"
HOMEPAGE="https://frigidcode.com/code/gfifteen/"
SRC_URI="https://frigidcode.com/code/gfifteen/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i -e "/Encoding/d" gfifteen.desktop || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README ChangeLog || die
	doicon ${PN}.svg
	domenu gfifteen.desktop
	prepgamesdirs
}
