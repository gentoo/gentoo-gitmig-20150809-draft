# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-WWW-Mechanize/Test-WWW-Mechanize-1.04.ebuild,v 1.3 2005/07/09 23:28:26 swegener Exp $

inherit perl-module

DESCRIPTION="Test::WWW::Mechanize is a subclass of WWW::Mechanize that
incorporates features for web application testing"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~ppc ~x86"
SRC_TEST="do"

DEPEND=">=dev-perl/WWW-Mechanize-1.00
	>=dev-perl/Test-LongString-0.07"

src_compile() {
	echo "y" | perl-module_src_compile
}
