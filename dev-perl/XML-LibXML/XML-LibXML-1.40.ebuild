# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/dev-perl/XML-LibXML/XML-LibXML-0.91-r1.ebuild,v 1.1 2001/10/06 14:36:55 azarah Exp

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${A}"
HOMEPAGE="http://cpan.valueclick.com/modules/by-category/11_String_Lang_Text_Proc/XML/${P}.readme"

DEPEND=">=sys-devel/perl-5
	>=dev-perl/XML-SAX-0.10
	>=dev-libs/libxml2-2.4.1"

src_compile() {
    perl Makefile.PL
    try make 
    try make test
}

#src_install () {
#    export PERL5_LIB=/var/tmp/portage/${P}/image/usr/lib/perl5/site_perl/5.6.1/
#	export PERLLIB=${D}/`perl -MConfig -e 'print $Config{sitelib}'`
#	try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
#	dodoc MANIFEST README
#}

src_install () {
	export PERL5LIB=`perl -e 'print map { ":$ENV{D}/$_" } @INC'`
#	try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 install
# hack around the make install "make install_sax_driver" stage since it breaks things :/

	try make PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 pure_install doc_install 
#	perl -MXML::SAX -e "XML::SAX->add_parser(q(XML::LibXML::SAX::Parser))->save_parsers()"
	dodoc MANIFEST README
}
pkg_postinst() {
	perl -MXML::SAX -e "XML::SAX->add_parser(q(XML::LibXML::SAX::Parser))->save_parsers()"
}	
		








