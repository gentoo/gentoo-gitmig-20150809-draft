# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/docklib/docklib-0.2.ebuild,v 1.10 2004/04/30 21:59:55 pvdabeel Exp $

DESCRIPTION="Library for Window Maker dock applications."
SRC_URI="http://linuxberg.surfnet.nl/files/x11/dev/${P}.tar.gz"
HOMEPAGE="http://www.windowmaker.org"
DEPEND="x11-base/xfree"
#RDEPEND=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"
IUSE=""

src_compile() {
	econf || die
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
