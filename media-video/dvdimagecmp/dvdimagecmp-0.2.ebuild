# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdimagecmp/dvdimagecmp-0.2.ebuild,v 1.3 2005/04/14 10:18:38 luckyduck Exp $

DESCRIPTION="Tool to compare a burned DVD with an image to check for errors"
HOMEPAGE="http://home.zonnet.nl/panteltje/dvd/"
SRC_URI="http://home.zonnet.nl/panteltje/dvd/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND=""

src_compile() {
	emake CFLAGS="$CFLAGS" || die "make failed"
}

src_install() {
	dobin dvdimagecmp
	dodoc CHANGES README *.lsm
}
