# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plonepopoll/plonepopoll-2.3.ebuild,v 1.1 2005/04/19 17:30:49 radek Exp $

inherit zproduct

MY_PN="PlonePopoll"

DESCRIPTION="Plone product which multiple choice pools"
HOMEPAGE="http://ingeniweb.sourceforge.net/Products/PlonePopoll/"
SRC_URI="mirror://sourceforge/ingeniweb/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
DEPEND=">=net-zope/plone-2.0"

ZPROD_LIST="${MY_PN}"
