# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Encoding/XML-Encoding-1.01.ebuild,v 1.2 2000/09/15 20:08:50 drobbins Exp $

P=XML-Encoding-1.01
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Perl Module that parses encoding map XML files"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"


src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    try make
}

src_install () {

    cd ${S}
    try make install
    prepman
    dodoc Changes README MANIFEST
}





