# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author CC Salvesen <calle@ioslo.net>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Perl module for using and building Perl SAX2 XML parsers, filters, and drivers"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/XML-NamespaceSupport-1.04
	>=dev-libs/libxml2-2.4.1"

src_compile() {
	echo n |perl Makefile.PL
	try make 
	try make test
}

#src_install () {
#	export PERLLIB=${D}/`perl -MConfig -e 'print $Config{sitelib}'`
#	try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
#	dodoc MANIFEST README
#}	
src_install () {
	export PERL5LIB=`perl -e 'print map { ":$ENV{D}/$_" } @INC'`
	try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
	dodoc MANIFEST README
}

