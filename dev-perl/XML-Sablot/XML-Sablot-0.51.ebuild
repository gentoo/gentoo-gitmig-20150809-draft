# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.51.ebuild,v 1.1 2001/04/30 09:46:42 achim Exp $

P=XML-Sablotron-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Perl Module for Sablotron"
#SRC_URI="http://www.gingerall.com/perl/rd?url=sablot/${A}"
#HOMEPAGE="http://www.gingerall.com/charlie-bin/get/webGA/act/xml-sab.act"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${PN}.${PV}.readme"

DEPEND=">=sys-devel/perl-5
	>=app-text/sablotron-0.44"

src_unpack() {

   unpack ${A}

}

src_compile() {

    cd ${S}
    perl Makefile.PL
    try make
    try make test

}

src_install () {

    cd ${S}
    try make PREFIX=${D}/usr install
    dodoc Changes README MANIFEST
}






