# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Twig/XML-Twig-3.13.ebuild,v 1.1 2004/02/16 16:52:47 mcummings Exp $

inherit perl-module

MY_P=XML-Twig-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"

DESCRIPTION="This module provides a way to process XML documents. It is build on top of XML::Parser"
HOMEPAGE="http://www.cpan.org/modules/by-module/XML/${MY_P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/XML/${MY_P}.tar.gz"

SRC_TEST="do"
LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="nls"

# Twig ONLY works with expat 1.95.5
DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.31
	dev-perl/Scalar-List-Utils
	>=dev-libs/expat-1.95.5
	dev-perl/Tie-IxHash
	dev-perl/XML-SAX-Writer
	dev-perl/XML-Handler-YAWriter
	nls? ( >=dev-perl/Text-Iconv-1.2-r1 )"

src_compile() {
	echo "" | perl-module_src_compile
	perl-module_src_test || die "test failed"
}
