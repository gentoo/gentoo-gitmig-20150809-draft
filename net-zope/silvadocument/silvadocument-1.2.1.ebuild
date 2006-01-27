# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/silvadocument/silvadocument-1.2.1.ebuild,v 1.2 2006/01/27 02:45:25 vapier Exp $

inherit zproduct

MY_PN="SilvaDocument"
DESCRIPTION="SilvaDocument provides the Silva Document, including its editor, for net-zope/silva"
HOMEPAGE="http://www.infrae.com/download/SilvaDocument/"
SRC_URI="${HOMEPAGE}/${PV}/${MY_PN}-${PV}.tgz"

LICENSE="ZPL"
KEYWORDS="~amd64 ~ppc ~x86"

ZPROD_LIST="${MY_PN}"
