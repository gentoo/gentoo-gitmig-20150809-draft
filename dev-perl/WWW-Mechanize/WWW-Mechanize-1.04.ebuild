# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Mechanize/WWW-Mechanize-1.04.ebuild,v 1.1 2004/10/17 21:19:33 mcummings Exp $

inherit perl-module

CATEGORY="dev-perl"
DESCRIPTION="automate interaction with websites "
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

DEPEND="dev-perl/IO-Socket-SSL
	>=dev-perl/libwww-perl-5.76
	dev-perl/URI
	dev-perl/HTML-Parser"

src_compile() {
	echo "y" | perl-module_src_compile
}
