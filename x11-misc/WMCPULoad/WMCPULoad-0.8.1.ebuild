# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# Maintainer: Vitaly Kushneriuk<vitaly@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/WMCPULoad/WMCPULoad-0.8.1.ebuild,v 1.3 2002/07/08 21:31:04 aliz Exp $

S=${WORKDIR}/${P}

DESCRIPTION="WMCPULoad is a program to monitor CPU usage."
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.bz2"
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/wmcpuload-e.html"
DEPEND="x11-base/xfree"
#RDEPEND=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
	#make || die
}

src_install () {
	make DESTDIR=${D} install || die
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
}
