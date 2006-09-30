# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/passwordresettool/passwordresettool-0.4.1.ebuild,v 1.1 2006/09/30 21:24:52 radek Exp $

inherit zproduct

MY_P="PasswordResetTool"
DESCRIPTION="From the Plone Collective. Mandatory for changing Zope's encrypted user passwords"
HOMEPAGE="http://plone.org/about/products/passwordresettool"
SRC_URI="http://plone.org/products/${PN}/releases/${PV}/${MY_P}-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~x86"

RDEPEND=">=net-zope/plone-2.0"

ZPROD_LIST="${MY_P}"
