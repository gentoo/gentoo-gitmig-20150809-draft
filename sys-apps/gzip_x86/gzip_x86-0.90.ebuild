# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gzip_x86/gzip_x86-0.90.ebuild,v 1.8 2003/06/21 21:19:39 drobbins Exp $

DESCRIPTION="gzip_x86 is an optimized gzip for x86 arch.  5-45% speed increase is offered during decompression"
HOMEPAGE="ftp://spruce.he.net/pub/jreiser"
SRC_URI="ftp://spruce.he.net/pub/jreiser/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 -ppc -sparc -alpha -arm -hppa -mips"
DEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
