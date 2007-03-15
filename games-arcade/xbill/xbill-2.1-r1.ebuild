# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/xbill/xbill-2.1-r1.ebuild,v 1.8 2007/03/15 22:31:47 nyhm Exp $

inherit eutils games

DESCRIPTION="A game about an evil hacker called Bill!"
HOMEPAGE="http://www.xbill.org/"
SRC_URI="http://www.xbill.org/download/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*"

src_compile() {
	egamesconf --enable-gtk || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon pixmaps/icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} XBill ${PN}.xpm
	dodoc ChangeLog README
	prepgamesdirs
}
