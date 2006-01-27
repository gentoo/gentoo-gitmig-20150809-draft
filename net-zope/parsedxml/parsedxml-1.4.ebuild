# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/parsedxml/parsedxml-1.4.ebuild,v 1.5 2006/01/27 02:39:45 vapier Exp $

inherit zproduct

DESCRIPTION="XML objects for Zope"
HOMEPAGE="http://www.infrae.com/download/ParsedXML"
SRC_URI="${HOMEPAGE}/${PV}/ParsedXML-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="~amd64 ~ppc x86"

RDEPEND=">=dev-python/pyxml-0.8.3"

ZPROD_LIST="ParsedXML"
MYDOC="README.DOMProxy README.parseprint ${MYDOC}"
