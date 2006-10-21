# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Spreadsheet-WriteExcel/Spreadsheet-WriteExcel-2.17-r1.ebuild,v 1.6 2006/10/21 14:31:58 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Write cross-platform Excel binary file."
SRC_URI="mirror://cpan/authors/id/J/JM/JMCNAMARA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jmcnamara/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc sparc ~x86"

SRC_TEST="do"

DEPEND="virtual/perl-File-Temp
	dev-perl/Parse-RecDescent
	dev-perl/OLE-StorageLite
	dev-perl/IO-stringy
	dev-lang/perl"
IUSE=""

