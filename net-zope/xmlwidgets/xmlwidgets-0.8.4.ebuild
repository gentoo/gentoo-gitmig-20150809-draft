# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/xmlwidgets/xmlwidgets-0.8.4.ebuild,v 1.1 2003/03/25 12:17:57 kutsuya Exp $

inherit zproduct

DESCRIPTION="UI widgets for Zope XML objects."
HOMEPAGE="http://www.zope.org/Members/faassen/XMLWidgets"
SRC_URI="${HOMEPAGE}/XMLWidgets-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="~x86"
RDEPEND=">=net-zope/parsedxml-1.3.1
         ${RDEPEND}"

ZPROD_LIST="XMLWidgets"


