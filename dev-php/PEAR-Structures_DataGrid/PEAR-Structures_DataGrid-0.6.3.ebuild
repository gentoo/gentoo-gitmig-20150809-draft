# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Structures_DataGrid/PEAR-Structures_DataGrid-0.6.3.ebuild,v 1.9 2006/02/18 20:16:47 agriffis Exp $

inherit php-pear-r1

DESCRIPTION="A tabular structure that contains a record set of data for paging
and sorting purposes."

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc ~ppc64 sparc x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-HTML_Table-1.5-r1
	>=dev-php/PEAR-Pager-2.3.3-r1
	>=dev-php/PEAR-Spreadsheet_Excel_Writer-0.8-r1
	>=dev-php/PEAR-XML_Util-1.1.1-r1
	>=dev-php/PEAR-XML_RSS-0.9.2-r1
	>=dev-php/PEAR-XML_Serializer-0.15.0-r1
	>=dev-php/PEAR-Console_Table-1.0.2-r1"
