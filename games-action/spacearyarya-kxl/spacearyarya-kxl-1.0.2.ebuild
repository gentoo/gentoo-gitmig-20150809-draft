# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/spacearyarya-kxl/spacearyarya-kxl-1.0.2.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

MY_P=SpaceAryarya-KXL-${PV}
DESCRIPTION="A 2D/3D shooting game"
SRC_URI="http://kxl.hn.org/download/${MY_P}.tar.gz"
HOMEPAGE="http://kxl.hn.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND=">=dev-games/KXL-1.1.4"

S=${WORKDIR}/${MY_P}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog COPYING README
	prepgamesdirs
}
