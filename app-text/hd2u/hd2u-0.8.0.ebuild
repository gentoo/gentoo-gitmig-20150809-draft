# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.6 2002/05/07 03:58:19 drobbins Exp

DESCRIPTION="Dos2Unix text file converter"
SRC_URI="http://www.megaloman.com/~hany/_data/hd2u/${P}.tgz"
HOMEPAGE="http://www.megaloman/~hany/"

KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="GPL-2"

RDEPEND="!app-text/dos2unix"

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS CREDITS ChangeLog INSTALL NEWS README TODO COPYING
}
