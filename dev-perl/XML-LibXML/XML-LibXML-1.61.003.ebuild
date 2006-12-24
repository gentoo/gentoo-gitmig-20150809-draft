# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML/XML-LibXML-1.61.003.ebuild,v 1.7 2006/12/24 00:49:07 dertobi123 Exp $

inherit perl-module eutils versionator

MY_S="${PN}-1.61"
MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_S}

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"
HOMEPAGE="http://cpan.org/modules/by-module/XML/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/P/PA/PAJAS/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ppc ~ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE=""

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
