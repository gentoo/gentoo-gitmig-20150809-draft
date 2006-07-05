# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.32.ebuild,v 1.13 2006/07/05 13:16:25 ian Exp $

inherit perl-module

DESCRIPTION="A perl XML down translate module"
SRC_URI="mirror://cpan/authors/id/J/JJ/JJOAO/${P}.tar.gz"
HOMEPAGE="http://search/cpan/org/~jjoao/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	dev-perl/XML-LibXML
	virtual/perl-Test-Simple
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	>=dev-perl/XML-Parser-2.31"
RDEPEND="${DEPEND}"

src_compile() {
	echo "" | perl-module_src_compile
}