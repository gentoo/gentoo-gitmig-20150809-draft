# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/xpenguins/xpenguins-2.2.ebuild,v 1.1 2003/09/10 18:14:05 vapier Exp $

inherit games

DESCRIPTION="Cute little penguins invading your desktop"
HOMEPAGE="http://xpenguins.seul.org/"
SRC_URI="http://xpenguins.seul.org/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/x11"

src_compile() {
	egamesconf --with-x
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
	prepgamesdirs
}
