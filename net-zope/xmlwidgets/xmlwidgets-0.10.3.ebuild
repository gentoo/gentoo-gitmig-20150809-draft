# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/xmlwidgets/xmlwidgets-0.10.3.ebuild,v 1.2 2004/10/14 20:22:06 radek Exp $

inherit zproduct

DESCRIPTION="UI widgets for Zope XML objects."
HOMEPAGE="http://www.infrae.com/download/XMLWidgets"
SRC_URI="${HOMEPAGE}/${PV}/XMLWidgets-${PV}.tgz"
LICENSE="ZPL"
IUSE=""
KEYWORDS="x86"
RDEPEND=">=net-zope/parsedxml-1.4
	${RDEPEND}"

ZPROD_LIST="XMLWidgets"
