# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hd2u/hd2u-0.8.0.ebuild,v 1.15 2004/07/13 22:01:47 agriffis Exp $

DESCRIPTION="Dos2Unix text file converter"
SRC_URI="http://www.megaloman.com/~hany/_data/hd2u/${P}.tgz"
HOMEPAGE="http://www.megaloman/~hany/"

KEYWORDS="x86 sparc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

RDEPEND="!app-text/dos2unix"

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS CREDITS ChangeLog INSTALL NEWS README TODO COPYING
}
