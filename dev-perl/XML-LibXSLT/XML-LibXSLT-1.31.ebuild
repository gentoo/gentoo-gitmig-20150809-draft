# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXSLT/XML-LibXSLT-1.31.ebuild,v 1.1 2002/04/28 04:21:53 g2boojum Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-libs/libxslt-1.0.1
	>=dev-perl/XML-LibXML-0.9"

src_compile() {

    perl Makefile.PL
    make || die
    make test || die
}

src_install () {

    make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install || die
    dodoc MANIFEST README

}









