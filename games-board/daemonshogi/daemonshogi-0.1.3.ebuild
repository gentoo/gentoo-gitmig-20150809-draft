# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/daemonshogi/daemonshogi-0.1.3.ebuild,v 1.2 2003/11/13 07:21:35 mr_bones_ Exp $

inherit games

DESCRIPTION="A GTK+ based, simple shogi (Japanese chess) program"
HOMEPAGE="http://www.users.yun.co.jp/~tokita/daemonshogi/"
SRC_URI="http://www.users.yun.co.jp/~tokita/daemonshogi/${P}.tar.gz"

KEYWORDS="x86 ppc sparc"
LICENSE="GPL-2 LGPL-2"
SLOT="0"

IUSE="nls"

DEPEND="gnome-base/gnome-libs
	>=sys-apps/sed-4"
RDEPEND="nls? ( >=sys-devel/gettext-0.10.38 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix the .po file for gettext-12 (bug 33347)
	sed -i \
		-e 's/ENCODING/8bit/' \
		-e 's/CHARSET/EUC-JP/' po/ja.po || \
			die "sed po/ja.po failed"
}

src_compile() {
	egamesconf `use_enable nls` || die
	emake                       || die "emake failed"
}

src_install() {
	egamesinstall                || die
	dodoc ChangeLog README* NEWS || die "dodoc failed"
	prepgamesdirs
}
