# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/xmlwidgets/xmlwidgets-0.10.3.ebuild,v 1.3 2005/02/21 21:35:52 blubb Exp $

inherit zproduct

DESCRIPTION="UI widgets for Zope XML objects."
HOMEPAGE="http://www.infrae.com/download/XMLWidgets"
SRC_URI="${HOMEPAGE}/${PV}/XMLWidgets-${PV}.tgz"
LICENSE="ZPL"
IUSE=""
KEYWORDS="x86 ~amd64"
RDEPEND=">=net-zope/parsedxml-1.4
	${RDEPEND}"

ZPROD_LIST="XMLWidgets"
