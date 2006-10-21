# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML/XML-LibXML-1.60.ebuild,v 1.4 2006/10/21 14:47:50 dertobi123 Exp $

inherit perl-module eutils

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
SRC_URI="mirror://cpan/authors/id/P/PA/PAJAS/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/XML/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha amd64 ~hppa ia64 ~mips ppc ~ppc64 sparc ~x86 ~x86-fbsd"

DEPEND=">=dev-perl/XML-SAX-0.12
	dev-perl/XML-LibXML-Common
	>=dev-libs/libxml2-2.6.6
	>=dev-perl/XML-NamespaceSupport-1.07
	dev-lang/perl"

SRC_TEST="do"

# rac can't discern any difference between the build with or without
# this, and if somebody wants to reactivate it, get it out of global
# scope.
#export PERL5LIB=`perl -e 'print map { ":$ENV{D}/$_" } @INC'`
mytargets="pure_install doc_install"

pkg_postinst() {

	perl-module_pkg_postinst

	perl -MXML::SAX \
		-e "XML::SAX->add_parser(q(XML::LibXML::SAX::Parser))->save_parsers()"

}

