# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sharutils/sharutils-4.2.1-r1.ebuild,v 1.3 2000/09/15 20:09:22 drobbins Exp $

P=sharutils-4.2.1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools to deal with shar archives"
SRC_URI="ftp://prep.ai.mit.edu/gnu/sharutils/${A}"

src_compile() {                           
	try ./configure --host=${CHOST} --prefix=/usr
	try make
}

src_unpack() {
    unpack ${A}
    cd ${S}/po
     mv nl.po nl.po.orig
     sed -e 's/aangemaakt/aangemaakt\\n/' nl.po.orig > nl.po
     mv pt.po pt.po.orig
     sed -e 's/de %dk/de %dk\\n/' pt.po.orig > pt.po
}

src_install() {                               
	cd ${S}
	try make prefix=${D}/usr install
	doman doc/*.[15]
	prepinfo
	rm -r ${D}/usr/share/locale
	mv ${D}/usr/lib/locale/ ${D}/usr/share/
	rm -rf ${D}/usr/lib
	cd ${S}
	dodoc AUTHORS BACKLOG COPYING ChangeLog ChangeLog.OLD NEWS README README.OLD THANKS TODO
}


