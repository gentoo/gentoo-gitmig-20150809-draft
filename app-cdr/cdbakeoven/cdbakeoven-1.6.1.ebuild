# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbakeoven/cdbakeoven-1.6.1.ebuild,v 1.2 2001/11/04 23:59:41 verwilst Exp $

S=${WORKDIR}/${P}

DESCRIPTION="CDBakeOven, KDE CD Writing Software"
SRC_URI="http://prdownloads.sourceforge.net/cdbakeoven/cdbakeoven-generic-1.6.1.tar.bz2"

HOMEPAGE="http://cdbakeoven.sourceforge.net"

DEPEND=">=x11-libs/qt-x11-2.2
	>=kde-base/kdelibs-2.2
	>=kde-base/kdebase-2.2"

RDEPEND=$DEPEND

src_unpack() {

	cd ${WORKDIR}
	unpack cdbakeoven-generic-1.6.1.tar.bz2
	mv cdbakeoven-generic-1.6.1 ${P}
	cd ${S}
}

src_compile() {

	./configure --prefix="/usr" --host=${CHOST} --with-xinerama || die
	make || die

}

src_install() {

	make install DESTDIR=${D} || die

}
