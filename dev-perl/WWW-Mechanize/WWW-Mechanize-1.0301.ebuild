# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Mechanize/WWW-Mechanize-1.0301.ebuild,v 1.9 2006/07/05 13:04:59 ian Exp $

inherit perl-module

MY_PV=${PV/0301/03_01}
MY_P=${PN}-${MY_PV}

S=${WORKDIR}/${MY_P}

DESCRIPTION="automate interaction with websites "
SRC_URI="http://search.cpan.org/CPAN/authors/id/P/PE/PETDANCE/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~petdance/${MY_P}"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ia64 ppc sparc x86"

DEPEND="dev-perl/IO-Socket-SSL
	>=dev-perl/libwww-perl-5.76
	dev-perl/URI
	dev-perl/HTML-Parser"
RDEPEND="${DEPEND}"

src_compile() {
	echo "y" | perl-module_src_compile
}