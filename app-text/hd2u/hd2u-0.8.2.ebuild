# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hd2u/hd2u-0.8.2.ebuild,v 1.7 2004/11/29 11:05:30 ka0ttic Exp $

DESCRIPTION="Dos2Unix text file converter"
SRC_URI="http://www.megaloman.com/~hany/_data/hd2u/${P}.tgz"
HOMEPAGE="http://www.megaloman.com/~hany/software/hd2u/"

KEYWORDS="x86 ~amd64 ~ppc ~sparc alpha ~hppa ~mips ~ia64 ppc64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="!app-text/dos2unix"

src_compile() {
	econf || die "configure failed"
	emake || die "compile failed"
}

src_install() {
	einstall
	dodoc AUTHORS COPYING CREDITS ChangeLog INSTALL NEWS README TODO
}
