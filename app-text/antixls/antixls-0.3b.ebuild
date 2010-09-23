# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/antixls/antixls-0.3b.ebuild,v 1.2 2010/09/23 08:44:47 grobian Exp $

DESCRIPTION="It is used to prints out an XLS file with minimal formatting, or extracts the data into CSV format."
HOMEPAGE="http://www.af0.net/~dan/?antixls"
SRC_URI="http://www.af0.net/~dan/repos/${P}.perl"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND="dev-perl/Spreadsheet-ParseExcel"

src_install() {
	mv "${DISTDIR}/${P}.perl" ${PN}
	dobin ${PN}
}
