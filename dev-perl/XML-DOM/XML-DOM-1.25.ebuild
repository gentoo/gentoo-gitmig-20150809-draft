# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM/XML-DOM-1.25.ebuild,v 1.3 2000/10/05 00:13:00 achim Exp $

P=XML-DOM-1.25
A=${P}.tar.gz
S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="A Perl module for an DOM Level 1 compliant interface"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"


src_compile() {

    cd ${S}
    perl Makefile.PL $PERLINSTALL
    try make 
    make test
}

src_install () {

    cd ${S}
    try make install
    prepman
    dodoc Changes MANIFEST README rfc2396.txt

}









