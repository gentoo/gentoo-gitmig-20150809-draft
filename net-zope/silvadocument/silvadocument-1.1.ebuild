# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/silvadocument/silvadocument-1.1.ebuild,v 1.2 2004/10/14 20:25:30 radek Exp $

inherit zproduct

MY_PN="SilvaDocument"
DESCRIPTION="SilvaDocument provides the Silva Document, including its editor, for net-zope/silva."
HOMEPAGE="http://www.infrae.com/download/${MY_PN}/"
SRC_URI="${HOMEPAGE}/${PV}/${MY_PN}-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="x86"
IUSE=""

ZPROD_LIST="${MY_PN}"
