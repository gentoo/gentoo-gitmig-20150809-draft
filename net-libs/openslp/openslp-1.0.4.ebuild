# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.0.4.ebuild,v 1.1 2001/11/13 16:13:17 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An open-source implementation of Service Location Protocol"
SRC_URI="http://prdownloads.sourceforge.net/openslp/${P}.tar.gz"
HOMEPAGE="http://www.openslp.org"

DEPEND="virtual/glibc"

src_compile() {

    ./configure --prefix=/usr --sysconfdir=/etc/slp --host=${CHOST} || die
    make || die

}

src_install () {

    make DESTDIR=${D} install || die
    dodoc AUTHORS COPYING ChangeLog NEWS README* THANKS 
    rm -rf ${D}/usr/doc
    docinto html
    cd doc
    dodoc html/*.html
    for i in IntroductionToSLP ProgrammersGuide UsersGuide
    do
	docinto html/*
        dodoc html/$i/*.{jpg,html}
    done
    docinto rfc
    dodoc rfc/*.{txt,html}

}

