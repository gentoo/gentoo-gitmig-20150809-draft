# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/hexxagon/hexxagon-0.3.2.ebuild,v 1.2 2004/02/24 00:01:42 mr_bones_ Exp $

inherit games

DESCRIPTION="clone of the original DOS game"
HOMEPAGE="http://nesqi.homeip.net/hexxagon/"
SRC_URI="http://nesqi.homeip.net/hexxagon/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc
	dev-libs/glib
	=x11-libs/gtk+-1*"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
	prepgamesdirs
}
