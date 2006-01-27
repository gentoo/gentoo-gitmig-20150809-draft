# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/xmlwidgets/xmlwidgets-0.10.3.ebuild,v 1.4 2006/01/27 02:49:28 vapier Exp $

inherit zproduct

DESCRIPTION="UI widgets for Zope XML objects"
HOMEPAGE="http://www.infrae.com/download/XMLWidgets"
SRC_URI="${HOMEPAGE}/${PV}/XMLWidgets-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="~amd64 x86"

RDEPEND=">=net-zope/parsedxml-1.4"

ZPROD_LIST="XMLWidgets"
