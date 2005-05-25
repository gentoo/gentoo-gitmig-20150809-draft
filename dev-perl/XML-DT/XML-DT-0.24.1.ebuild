# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.24.1.ebuild,v 1.8 2005/05/25 14:56:13 mcummings Exp $

inherit perl-module

DESCRIPTION="A perl XML down translate module"
SRC_URI="mirror://cpan/authors/id/J/JJ/JJOAO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jjoao/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc ~sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/libwww-perl
	dev-perl/XML-LibXML
	perl-core/Test-Simple
	>=dev-perl/XML-Parser-2.31"

src_compile() {
	echo "" | perl-module_src_compile
}
