# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/daemonshogi/daemonshogi-0.1.3.ebuild,v 1.3 2003/11/15 22:03:46 mr_bones_ Exp $

inherit games

DESCRIPTION="A GTK+ based, simple shogi (Japanese chess) program"
HOMEPAGE="http://www.users.yun.co.jp/~tokita/daemonshogi/"
SRC_URI="http://www.users.yun.co.jp/~tokita/daemonshogi/${P}.tar.gz"

KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2 LGPL-2"
SLOT="0"

IUSE="nls"

DEPEND="gnome-base/gnome-libs
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_compile() {
	if use nls && has_version '>=sys-devel/gettext-0.12' ; then
		export XGETTEXT="/usr/bin/xgettext --from-code=EUC-JP"
	fi
	egamesconf `use_enable nls` || die
	emake                       || die "emake failed"
}

src_install() {
	egamesinstall                || die
	dodoc ChangeLog README* NEWS || die "dodoc failed"
	prepgamesdirs
}
