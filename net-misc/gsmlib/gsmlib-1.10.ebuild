# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsmlib/gsmlib-1.10.ebuild,v 1.4 2003/02/28 16:55:00 liquidx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Library and Applications to access GSM mobile phones"
SRC_URI="http://www.pxh.de/fs/gsmlib/download/${P}.tar.gz"
HOMEPAGE="http://www.pxh.de/fs/gsmlib/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc"

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README
}
