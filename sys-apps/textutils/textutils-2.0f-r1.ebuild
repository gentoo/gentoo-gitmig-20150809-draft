# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/textutils/textutils-2.0f-r1.ebuild,v 1.3 2000/08/21 05:39:46 achim Exp $

P=textutils-2.0f
A=${P}.tar.gz
S=${WORKDIR}/${P}

DESCRIPTION="Standard GNU text utilities"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/textutils-2.0f.tar.gz"

src_compile() {                           
	./configure --prefix=/usr --host=${CHOST} \
	--with-catgets --without-included-regex
	make
}

src_unpack() {
    unpack ${A}
    cd ${S}/src
    mv tr.c tr.c.orig
    sed -e "234d" tr.c.orig > tr.c
#    cp sys2.h sys2.h.orig
#    sed -e "s:^char \*strndup://:" sys2.h.orig > sys2.h
}

src_install() {                               
	cd ${S}
	make prefix=${D}/usr install
	prepman
	prepinfo
	dodoc AUTHORS COPYING ChangeLog NEWS README* THANKS TODO 
	dodir /bin
	dosym /usr/bin/cat /bin/cat
	rmdir ${D}/usr/lib
}




