# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-admin/fcron/fcron-1.1.0.ebuild,v 1.1 2001/05/08 00:09:29 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A replacement for vcron"
SRC_URI="http://fcron.free.fr/${P}.src.tar.gz"
HOMEPAGE="http://fcron.free.fr/"

DEPEND="virtual/glibc virtual/mta"
src_compile() {

    try ./configure --prefix=/usr --host=${CHOST} \
	--with-etcdir=/etc/fcron \
	--with-spooldir=/var/spool/fcron \
	--with-sendmail=/usr/sbin/sendmail \
    --with-username=cron \
    --with-groupname=cron
    cp Makefile Makefile.orig
    sed -e "s:\$(SRCDIR)/script/boot-install:#:" Makefile.orig > Makefile
    try make CFLAGS=\"${CFLAGS}\"

}

src_install () {

    try make prefix=${D}/usr \
	DESTMAN=${D}/usr/share/man \
	DESTDOC=${D}/usr/share/doc/${PF} \
	FCRONTABS=${D}/var/spool/fcron \
	ETC=${D}/etc/fcron  install
    dodoc MANIFEST VERSION doc/CHANGES doc/README doc/LICENSE
    docinto html
    dodoc doc/*.html
    rm -rf ${D}/usr/share/doc/${PF}/${PN}-${PV}
}

