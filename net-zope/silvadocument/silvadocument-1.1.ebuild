# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/silvadocument/silvadocument-1.1.ebuild,v 1.3 2005/02/21 21:33:56 blubb Exp $

inherit zproduct

MY_PN="SilvaDocument"
DESCRIPTION="SilvaDocument provides the Silva Document, including its editor, for net-zope/silva."
HOMEPAGE="http://www.infrae.com/download/${MY_PN}/"
SRC_URI="${HOMEPAGE}/${PV}/${MY_PN}-${PV}.tgz"
LICENSE="ZPL"
KEYWORDS="x86 ~amd64"
IUSE=""

ZPROD_LIST="${MY_PN}"
