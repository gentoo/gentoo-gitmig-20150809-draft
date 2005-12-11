# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plonepopoll/plonepopoll-2.3.ebuild,v 1.3 2005/12/11 19:25:36 radek Exp $

inherit zproduct

MY_PN="PlonePopoll"

DESCRIPTION="Plone product which provides multiple choice polls"
HOMEPAGE="http://ingeniweb.sourceforge.net/Products/PlonePopoll/"
SRC_URI="mirror://sourceforge/ingeniweb/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-zope/plone-2.0"

ZPROD_LIST="${MY_PN}"
