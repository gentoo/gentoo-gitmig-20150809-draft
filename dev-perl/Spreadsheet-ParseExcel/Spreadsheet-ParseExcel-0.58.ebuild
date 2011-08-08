# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Spreadsheet-ParseExcel/Spreadsheet-ParseExcel-0.58.ebuild,v 1.3 2011/08/08 20:00:44 grobian Exp $

EAPI=3

MODULE_AUTHOR=JMCNAMARA
inherit perl-module

DESCRIPTION="Get information from Excel file"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86 ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="test cjk unicode"

RDEPEND=">=dev-perl/OLE-StorageLite-0.19
	dev-perl/IO-stringy
	dev-perl/Text-CSV_XS
	unicode? ( dev-perl/Unicode-Map )
	cjk? ( dev-perl/Jcode )"
DEPEND="
	test? ( dev-perl/Test-Pod
		dev-perl/Unicode-Map
		dev-perl/Spreadsheet-WriteExcel
		dev-perl/Jcode )
	${RDEPEND}"

SRC_TEST="do"
