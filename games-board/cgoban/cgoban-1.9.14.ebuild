# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/cgoban/cgoban-1.9.14.ebuild,v 1.4 2004/07/01 11:10:24 eradicator Exp $

inherit games

DESCRIPTION="A Go-frontend"
HOMEPAGE="http://cgoban1.sourceforge.net/"
SRC_URI="mirror://sourceforge/cgoban1/${P}.tar.gz"

KEYWORDS="x86 ppc amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libc
	virtual/x11"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
	prepgamesdirs
}
