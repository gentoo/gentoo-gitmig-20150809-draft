# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.40.ebuild,v 1.4 2005/08/19 19:39:12 hansmi Exp $

inherit perl-module

DESCRIPTION="A perl XML down translate module"
SRC_URI="mirror://cpan/authors/id/A/AM/AMBS/XML/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ambs/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/libwww-perl-1.35
	|| ( >=dev-perl/XML-LibXML-1.54 >=dev-perl/XML-Parser-2.31 )
	>=dev-perl/XML-DTDParser-2.00
	perl-core/Test-Simple
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage"

src_compile() {
	echo "" | perl-module_src_compile
}
