# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/parsedxml/parsedxml-1.4.ebuild,v 1.3 2004/10/23 22:38:19 lanius Exp $

inherit zproduct

DESCRIPTION="XML objects for Zope."
HOMEPAGE="http://www.infrae.com/download/ParsedXML"
SRC_URI="${HOMEPAGE}/${PV}/ParsedXML-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="x86 ~ppc"
IUSE=""
RDEPEND=">=dev-python/pyxml-0.8.3
	${RDEPEND}"

ZPROD_LIST="ParsedXML"
MYDOC="README.DOMProxy README.parseprint ${MYDOC}"
