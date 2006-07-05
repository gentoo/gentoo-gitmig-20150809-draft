# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Mechanize/WWW-Mechanize-1.04.ebuild,v 1.7 2006/07/05 13:04:59 ian Exp $

inherit perl-module

DESCRIPTION="automate interaction with websites "
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~petdance/${P}/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ppc sparc x86"

DEPEND="dev-perl/IO-Socket-SSL
	>=dev-perl/libwww-perl-5.76
	dev-perl/URI
	dev-perl/HTML-Parser"
RDEPEND="${DEPEND}"

src_compile() {
	echo "y" | perl-module_src_compile
}