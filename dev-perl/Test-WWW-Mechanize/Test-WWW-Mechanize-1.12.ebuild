# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-WWW-Mechanize/Test-WWW-Mechanize-1.12.ebuild,v 1.5 2007/03/23 20:48:54 ticho Exp $

inherit perl-module

DESCRIPTION="Test::WWW::Mechanize is a subclass of WWW::Mechanize that
incorporates features for web application testing"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
SRC_TEST="do"

DEPEND=">=dev-perl/WWW-Mechanize-1.00
	dev-perl/Carp-Assert-More
	>=dev-perl/HTTP-Server-Simple-0.07
	dev-perl/URI
	>=dev-perl/Test-LongString-0.07
	dev-lang/perl"

src_compile() {
	echo "y" | perl-module_src_compile
}


