# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# /home/cvsroot/gentoo-x86/app-admin/fcron/fcron-0.9.4.ebuild,v 1.1 2001/01/02 18:50:03 achim Exp

S=${WORKDIR}/${P}
DESCRIPTION="A replacement for vcron"
SRC_URI="http://fcron.free.fr/${P}.src.tar.gz"
HOMEPAGE="http://fcron.free.fr/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
	--with-etcdir=/etc/fcron \
	--with-spooldir=/var/spool/fcron \
	--with-sendmail=/usr/sbin/sendmail 
    cp Makefile Makefile.orig
    sed -e "s:script/:#script/:" Makefile.orig > Makefile
    try make

}

src_install () {

    cd ${S}
    
    try make prefix=${D}/usr \
	DESTMAN=${D}/usr/man \
	DESTDOC=${D}/usr/doc/${PF} \
	FCRONTABS=${D}/var/spool/fcron \
	ETC=${D}/etc/fcron  install
    dodoc MANIFEST VERSION doc/CHANGES doc/README doc/LICENSE
    docinto html
    dodoc doc/*.html
    rm -rf ${D}/usr/doc/${PF}/${PN}-${PV}
}

