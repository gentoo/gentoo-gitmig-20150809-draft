# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/docklib/docklib-0.2.ebuild,v 1.7 2003/09/29 21:42:20 mholzer Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Library for Window Maker dock applications."
SRC_URI="http://linuxberg.surfnet.nl/files/x11/dev/${P}.tar.gz"
HOMEPAGE="http://www.windowmaker.org"
DEPEND="x11-base/xfree"
#RDEPEND=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
}
