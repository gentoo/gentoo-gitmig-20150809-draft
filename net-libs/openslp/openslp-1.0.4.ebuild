# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.0.4.ebuild,v 1.3 2002/07/11 06:30:47 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An open-source implementation of Service Location Protocol"
SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"
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

