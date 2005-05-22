# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.40.ebuild,v 1.1 2005/05/22 17:54:36 mcummings Exp $

inherit perl-module

DESCRIPTION="A perl XML down translate module"
SRC_URI="mirror://cpan/authors/id/A/AM/AMBS/XML/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ambs/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/libwww-perl-1.35
	||( >=dev-perl/XML-LibXML-1.54 >=dev-perl/XML-Parser-2.31 )
	>=dev-perl/XML-DTDParser-2.00
	dev-perl/Test-Simple
	dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage"

src_compile() {
	echo "" | perl-module_src_compile
}
