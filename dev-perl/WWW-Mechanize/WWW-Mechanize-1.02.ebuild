# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Mechanize/WWW-Mechanize-1.02.ebuild,v 1.4 2004/07/14 20:57:05 agriffis Exp $

inherit perl-module

CATEGORY="dev-perl"
DESCRIPTION="automate interaction with websites "
SRC_URI="http://search.cpan.org/CPAN/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~petdance/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

DEPEND="dev-perl/IO-Socket-SSL
	dev-perl/libwww-perl"

src_compile() {
	echo "y" | perl-module_src_compile
}
