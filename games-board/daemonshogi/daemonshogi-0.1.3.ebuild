# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/daemonshogi/daemonshogi-0.1.3.ebuild,v 1.7 2006/04/28 19:36:34 tupone Exp $

inherit eutils games

DESCRIPTION="A GTK+ based, simple shogi (Japanese chess) program"
HOMEPAGE="http://www.users.yun.co.jp/~tokita/daemonshogi/"
SRC_URI="http://www.users.yun.co.jp/~tokita/daemonshogi/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc ~amd64"
SLOT="0"
IUSE="nls"

DEPEND="gnome-base/gnome-libs
	nls? ( >=sys-devel/gettext-0.10.38 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}"-sandbox.patch
}

src_compile() {
	if use nls && has_version '>=sys-devel/gettext-0.12' ; then
		export XGETTEXT="/usr/bin/xgettext --from-code=EUC-JP"
	fi
	egamesconf `use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog README* NEWS
	prepgamesdirs
}
