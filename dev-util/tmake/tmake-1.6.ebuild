# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/tmake/tmake-1.6.ebuild,v 1.2 2001/06/07 21:10:33 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Cross platform Makefile tool"
SRC_URI="ftp://ftp.trolltech.com/freebies/tmake/${P}.tar.gz"
HOMEPAGE="http://www.trolltech.com/products/download/freebies/tmake.html"

RDEPEND="sys-devel/perl"

src_install () {

    cd ${S}
    dobin bin/tmake bin/progen
    dodir /usr/lib/tmake
    cp -af ${S}/lib/* ${D}/usr/lib/tmake
    dodoc CHANGES LICENSE README
    docinto html
    dodoc doc/*.html
    

}

