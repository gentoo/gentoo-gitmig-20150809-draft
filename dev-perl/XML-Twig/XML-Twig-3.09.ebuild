# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Twig/XML-Twig-3.09.ebuild,v 1.5 2003/06/21 21:36:44 drobbins Exp $

IUSE="nls"

inherit perl-module

MY_P=XML-Twig-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"

DESCRIPTION="This module provides a way to process XML documents. It is build on top of XML::Parser"
SRC_URI="http://www.cpan.org/modules/by-module/XML/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/XML/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

# Twig ONLY works with expat 1.95.5
DEPEND="${DEPEND} dev-perl/XML-Parser
	dev-perl/Scalar-List-Utils 
	>=dev-libs/expat-1.95.5
	nls? ( >=dev-perl/Text-Iconv-1.2-r1 )"

src_compile() {
	perl-module_src_compile
	perl-module_src_test || die "test failed"
}
