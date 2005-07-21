# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Structures_DataGrid/PEAR-Structures_DataGrid-0.6.2.ebuild,v 1.1 2005/07/21 06:12:10 sebastian Exp $

inherit php-pear

DESCRIPTION="A tabular structure that contains a record set of data for paging
and sorting purposes."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""
RDEPEND=">=dev-php/PEAR-HTML_Table-1.5
	>=dev-php/PEAR-Pager-2.2
	>=dev-php/PEAR-Spreadsheet_Excel_Writer-0.6
	>=dev-php/PEAR-XML_Util-0.5.2
	>=dev-php/PEAR-XML_RSS-0.9.2
	>=dev-php/PEAR-XML_Serializer-0.11.1
	>=dev-php/PEAR-Console_Table-1.0.1"
