# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DOM/XML-DOM-1.25.ebuild,v 1.7 2001/04/09 05:08:37 achim Exp $

P=XML-DOM-1.25
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl module for an DOM Level 1 compliant interface"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/XML-Parser-2.29"

src_unpack() {
  unpack ${A}
  cd ${S}
  cp DOM.pm DOM.pm.orig
  sed -e 's:\\\d:[0-9]:' DOM.pm.orig > DOM.pm
}

src_compile() {

    perl Makefile.PL 
    try make 
    make test
}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
    dodoc Changes MANIFEST README 

}









