# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Sablot/XML-Sablot-0.51.ebuild,v 1.2 2001/05/03 16:38:57 achim Exp $

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

    perl Makefile.PL
    try make
    try make test

}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes README MANIFEST
}






