# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hd2u/hd2u-0.8.2.ebuild,v 1.2 2004/02/22 20:03:32 agriffis Exp $

DESCRIPTION="Dos2Unix text file converter"
SRC_URI="http://www.megaloman.com/~hany/_data/hd2u/${P}.tgz"
HOMEPAGE="http://www.megaloman.com/~hany/software/hd2u/"

KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips ~ia64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""
S=${WORKDIR}/${P}

RDEPEND="!app-text/dos2unix"

src_compile() {
	econf || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	einstall
	dodoc AUTHORS COPYING CREDITS ChangeLog INSTALL NEWS README TODO
}
