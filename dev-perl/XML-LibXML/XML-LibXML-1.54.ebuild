# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML/XML-LibXML-1.54.ebuild,v 1.5 2003/04/24 21:08:56 rac Exp $


inherit perl-module


MY_P="${P}_0"

S=${WORKDIR}/${P}
DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI="http://search.cpan.org/CPAN/authors/id/P/PH/PHISH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/src/PHISH/XML-LibXML-1.54_0/README"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~alpha ppc ~sparc "

DEPEND="${DEPEND}
	>=dev-perl/XML-SAX-0.12
	dev-perl/XML-LibXML-Common
	>=dev-libs/libxml2-2.4.1
	>=dev-perl/XML-NamespaceSupport-1.07"

export PERL5LIB=`perl -e 'print map { ":$ENV{D}/$_" } @INC'`
mytargets="pure_install doc_install"


pkg_postinst() {

	perl-post_pkg_postinst

	perl -MXML::SAX \
		-e "XML::SAX->add_parser(q(XML::LibXML::SAX::Parser))->save_parsers()"

}	
