# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.44.ebuild,v 1.1 2000/09/20 17:16:52 achim Exp $

P=XML-Sablotron-0.44
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Perl Module for Sablotron"
SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/${A}"
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






