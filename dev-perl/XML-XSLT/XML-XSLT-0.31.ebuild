# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XSLT/XML-XSLT-0.31.ebuild,v 1.2 2001/05/03 16:38:58 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl module to parse XSL Transformational sheets"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/XML-Parser-2.29
	>=dev-perl/XML-DOM-1.25
	>=dev-perl/libwww-perl-5.48"

src_compile() {

    perl Makefile.PL 
    try make 
    try make test
}

src_install () {

    try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	INSTALLMAN1DIR=${D}/usr/share/man/man1 install
    dodoc MANIFEST README

}









