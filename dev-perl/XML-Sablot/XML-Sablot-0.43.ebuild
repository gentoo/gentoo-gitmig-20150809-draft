# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.43.ebuild,v 1.3 2000/09/15 20:08:50 drobbins Exp $

P=XML-Sablotron-0.43
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Perl Module"
SRC_URI="http://www.gingerall.com/download/${A}"
HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/xml-sab.act"


src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    try make
    try make test

}

src_install () {

    cd ${S}
    try make install
    prepman
    dodoc Changes README MANIFEST
}






