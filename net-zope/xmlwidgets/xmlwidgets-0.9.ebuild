# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/xmlwidgets/xmlwidgets-0.9.ebuild,v 1.6 2006/01/27 02:49:28 vapier Exp $

inherit zproduct

DESCRIPTION="UI widgets for Zope XML objects"
HOMEPAGE="http://www.zope.org/Members/faassen/XMLWidgets"
SRC_URI="${HOMEPAGE}/XMLWidgets-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="~ppc ~x86"

RDEPEND=">=net-zope/parsedxml-1.3.1"

ZPROD_LIST="XMLWidgets"
