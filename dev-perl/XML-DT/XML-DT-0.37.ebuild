# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.37.ebuild,v 1.4 2005/04/01 18:03:09 blubb Exp $

inherit perl-module

DESCRIPTION="A perl XML down translate module"
SRC_URI="mirror://cpan/authors/id/J/JJ/JJOAO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jjoao/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/libwww-perl-1.35
	dev-perl/XML-LibXML
	dev-perl/XML-DTDParser
	dev-perl/Test-Simple
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	>=dev-perl/XML-Parser-2.31"

src_compile() {
	echo "" | perl-module_src_compile
}
