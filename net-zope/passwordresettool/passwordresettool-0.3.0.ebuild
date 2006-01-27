# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/passwordresettool/passwordresettool-0.3.0.ebuild,v 1.2 2006/01/27 02:40:05 vapier Exp $

inherit zproduct

MY_P="PasswordResetTool"
DESCRIPTION="From the Plone Collective. Mandatory for changing Zope's encrypted user passwords"
HOMEPAGE="http://sf.net/projects/collective"
SRC_URI="mirror://sourceforge/collective/${MY_P}-${PV}.tar.gz"

LICENSE="ZPL"
KEYWORDS="~x86"

RDEPEND=">=net-zope/plone-2.0"

ZPROD_LIST="${MY_P}"
