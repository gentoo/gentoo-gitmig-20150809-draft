# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/xmlwidgets/xmlwidgets-0.8.5.ebuild,v 1.4 2004/04/05 08:07:36 mr_bones_ Exp $

inherit zproduct

DESCRIPTION="UI widgets for Zope XML objects."
HOMEPAGE="http://www.zope.org/Members/faassen/XMLWidgets"
SRC_URI="${HOMEPAGE}/XMLWidgets-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"
RDEPEND=">=net-zope/parsedxml-1.3.1
	${RDEPEND}"

ZPROD_LIST="XMLWidgets"
