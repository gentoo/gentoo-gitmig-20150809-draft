# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/xpenguins/xpenguins-2.2.ebuild,v 1.3 2004/02/03 01:08:25 mr_bones_ Exp $

inherit games

DESCRIPTION="Cute little penguins invading your desktop"
HOMEPAGE="http://xpenguins.seul.org/"
SRC_URI="http://xpenguins.seul.org/${P}.tar.gz"

KEYWORDS="x86 ppc sparc alpha ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	egamesconf --with-x || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
	prepgamesdirs
}
