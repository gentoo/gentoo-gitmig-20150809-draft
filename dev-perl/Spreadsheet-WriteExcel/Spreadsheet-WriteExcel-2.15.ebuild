# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Spreadsheet-WriteExcel/Spreadsheet-WriteExcel-2.15.ebuild,v 1.6 2006/07/04 19:59:36 ian Exp $

inherit perl-module

DESCRIPTION="Write cross-platform Excel binary file."
SRC_URI="mirror://cpan/authors/id/J/JM/JMCNAMARA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jmcnamara/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ppc sparc x86"

SRC_TEST="do"

DEPEND="virtual/perl-File-Temp
	dev-perl/Parse-RecDescent"
RDEPEND="${DEPEND}"
IUSE=""