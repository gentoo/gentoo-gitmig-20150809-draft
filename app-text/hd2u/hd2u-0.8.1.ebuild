# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hd2u/hd2u-0.8.1.ebuild,v 1.1 2003/09/20 04:05:56 iggy Exp $

DESCRIPTION="Dos2Unix text file converter"
SRC_URI="http://www.megaloman.com/~hany/_data/hd2u/${P}.tgz"
HOMEPAGE="http://www.megaloman/~hany/"

KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~ia64"
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
