# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>


S=${WORKDIR}/${P}

DESCRIPTION="CDBakeOven, KDE CD Writing Software"
SRC_URI="http://prdownloads.sourceforge.net/cdbakeoven/cdbakeoven-generic-1.6.1.tar.bz2"

HOMEPAGE="http://cdbakeoven.sourceforge.net"

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