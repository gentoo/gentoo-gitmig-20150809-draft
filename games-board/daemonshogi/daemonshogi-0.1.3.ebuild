# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/daemonshogi/daemonshogi-0.1.3.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

inherit games

DESCRIPTION="A GTK+ based, simple shogi (Japanese chess) program"
HOMEPAGE="http://www.users.yun.co.jp/~tokita/daemonshogi/"
SRC_URI="http://www.users.yun.co.jp/~tokita/daemonshogi/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE="nls"

DEPEND="gnome-base/gnome-libs"
RDEPEND="nls? ( >=sys-devel/gettext-0.10.38 )"

src_compile() {
	egamesconf `use_enable nls` || die
	emake || die
}

src_install() {
	egamesinstall || die
	dodoc ChangeLog README* NEWS
	prepgamesdirs
}
